From: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>
Subject: Re: GIT get corrupted on lustre
Date: Fri, 18 Jan 2013 12:50:11 -0500
Message-ID: <50F98B53.9080109@giref.ulaval.ca>
References: <50D861EE.6020105@giref.ulaval.ca> <50D870A0.90205@interlinx.bc.ca> <50EC453A.2060306@giref.ulaval.ca> <50EDDF12.3080800@giref.ulaval.ca> <50F7F793.80507@giref.ulaval.ca> <CAGK7Mr4R=OwfWt4Kat75C8YDi3iLTavMLxeoLxkf1-gKhxrucg@mail.gmail.com> <50F8273E.5050803@giref.ulaval.ca> <871B6C10EBEFE342A772D1159D1320853A042AD7@umechphj.easf.csd.disa.mil> <50F829A9.7090606@calculquebec.ca> <871B6C10EBEFE342A772D1159D1320853A044B42@umechphj.easf.csd.disa.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Maxime Boissonneault <maxime.boissonneault@calculquebec.ca>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	=?ISO-8859-1?Q?S=E9bastien_?= =?ISO-8859-1?Q?Boisvert?= 
	<sebastien.boisvert@calculquebec.ca>
To: "Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>
X-From: git-owner@vger.kernel.org Fri Jan 18 18:50:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwG5P-0003ZG-Go
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 18:50:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815Ab3ARRuS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jan 2013 12:50:18 -0500
Received: from serveur.giref.ulaval.ca ([132.203.7.102]:52684 "EHLO
	mailhost.giref.ulaval.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab3ARRuR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 12:50:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id 3867410192C;
	Fri, 18 Jan 2013 12:50:12 -0500 (EST)
X-Virus-Scanned: amavisd-new at giref.ulaval.ca
Received: from mailhost.giref.ulaval.ca ([127.0.0.1])
	by localhost (mailhost.giref.ulaval.ca [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 07wSvtmIxND3; Fri, 18 Jan 2013 12:50:11 -0500 (EST)
Received: from [132.203.7.22] (melkor.giref.ulaval.ca [132.203.7.22])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id 3B27C10111C;
	Fri, 18 Jan 2013 12:50:11 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130105 Thunderbird/17.0.2
In-Reply-To: <871B6C10EBEFE342A772D1159D1320853A044B42@umechphj.easf.csd.disa.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213919>

Good idea!

I did a strace and here is the output with the error:

http://www.giref.ulaval.ca/~ericc/strace_git_error.txt

Hope it will be insightful!

Eric


On 01/17/2013 12:17 PM, Pyeron, Jason J CTR (US) wrote:
> Sorry, I am in cygwin mode, and I had crossed wires in my head. s/Pro=
cessMon/strace/
>
>> -----Original Message-----
>> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] O=
n
>> Behalf Of Maxime Boissonneault
>> Sent: Thursday, January 17, 2013 11:41 AM
>> To: Pyeron, Jason J CTR (US)
>> Cc: Eric Chamberland; Philippe Vaucher; git@vger.kernel.org; S=E9bas=
tien
>> Boisvert
>> Subject: Re: GIT get corrupted on lustre
>>
>> I don't know of any lustre filesystem that is used on Windows. Barel=
y
>> anybody uses Windows in the HPC industry.
>> This is a Linux cluster.
>>
>> Maxime Boissonneault
>>
>> Le 2013-01-17 11:40, Pyeron, Jason J CTR (US) a =E9crit :
>>>> -----Original Message-----
>>>> From: Eric Chamberland
>>>> Sent: Thursday, January 17, 2013 11:31 AM
>>>>
>>>> On 01/17/2013 09:23 AM, Philippe Vaucher wrote:
>>>>>> Anyone has a new idea?
>>>>> Did you try Jeff King's code to confirm his idea?
>>>>>
>>>>> Philippe
>>>>>
>>>> Yes I did, but it was running without any problem....
>>>>
>>>> I find that my test case is "simple" (fresh git clone then "git gc=
"
>> in
>>>> a
>>>> crontab), I bet anyone who has access to a Lustre filesystem can
>>>> reproduce the problem...  The problem is to have such a filesystem
>> to
>>>> do
>>>> the tests....
>>> Stabbing in the dark, but can you log the details with ProcessMon?
>>>
>>> http://technet.microsoft.com/en-us/sysinternals/bb896645
>>>
>>>> But I am available to do it...
>>> -Jason
>>
>>
>> --
>> ---------------------------------
>> Maxime Boissonneault
>> Analyste de calcul - Calcul Qu=E9bec, Universit=E9 Laval
>> Ph. D. en physique
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
