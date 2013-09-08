From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Sun, 8 Sep 2013 09:42:03 +0100
Organization: OPDS
Message-ID: <01BEC88E9B724BA4986F2678A4D9F4E6@PhilipOakley>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com><xmqqd2opu8hr.fsf@gitster.dls.corp.google.com><CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com><xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com><20130904081047.GB2582@serenity.lan><xmqqa9jso69u.fsf@gitster.dls.corp.google.com><7DC052455C7C4B50A4EAFC1EF63D006C@PhilipOakley><xmqqr4d4jird.fsf@gitster.dls.corp.google.com><20130905080606.GE2582@serenity.lan><CAMP44s1Rb2WKGD-QfNh055099R+9FHv9W8TA8Gfjp=qZh_7p7Q@mail.gmail.com><8B7F235220624B259BB32B293BCB3E96@PhilipOakley> <CAMP44s2pw2TZSZ6pL-kx_QQCkjKrprERyvddCT-HTeo7uRNENA@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "John Keeping" <john@keeping.me.uk>,
	"Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>,
	"Andreas Krey" <a.krey@gmx.de>
To: "Felipe Contreras" <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 10:42:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIaZL-0000bp-FQ
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 10:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980Ab3IHImD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 04:42:03 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:51817 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751837Ab3IHImA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Sep 2013 04:42:00 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgMMADo3LFJOl3GZ/2dsb2JhbABbgwc4g3uFPrkYBAQBgSIXdIIgBQEBBAEIAQEZFR4BASEFBgIDBQIBAxEEAQEBAgIFIQICFAEECBIGBw8IBhMIAgECAwEKh1UDCQoItgWHdw2IdwSBKYtpgm6CcDSBAAOPD4UMgXGOIIUvgyE7
X-IPAS-Result: AgMMADo3LFJOl3GZ/2dsb2JhbABbgwc4g3uFPrkYBAQBgSIXdIIgBQEBBAEIAQEZFR4BASEFBgIDBQIBAxEEAQEBAgIFIQICFAEECBIGBw8IBhMIAgECAwEKh1UDCQoItgWHdw2IdwSBKYtpgm6CcDSBAAOPD4UMgXGOIIUvgyE7
X-IronPort-AV: E=Sophos;i="4.90,863,1371078000"; 
   d="scan'208";a="441403184"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip01ir2.opaltelecom.net with SMTP; 08 Sep 2013 09:41:59 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234225>

From: "Felipe Contreras" <felipe.contreras@gmail.com>
To: "Philip Oakley" <philipoakley@iee.org>
Cc: "John Keeping" <john@keeping.me.uk>; "Junio C Hamano" 
<gitster@pobox.com>; <git@vger.kernel.org>; "Andreas Krey" 
<a.krey@gmx.de>
Sent: Sunday, September 08, 2013 9:16 AM
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default


> On Sun, Sep 8, 2013 at 3:01 AM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>> From: "Felipe Contreras" <felipe.contreras@gmail.com>
>> Sent: Sunday, September 08, 2013 3:34 AM
>>
>>> On Thu, Sep 5, 2013 at 3:06 AM, John Keeping <john@keeping.me.uk> 
>>> wrote:
>>>>
>>>> On Wed, Sep 04, 2013 at 03:59:18PM -0700, Junio C Hamano wrote:
>>>>>
>>>>> Are there cases where you do not want to either rebase nor merge?
>>>>> If so what do you want to do after "git pull" fetches from the 
>>>>> other
>>>>> side?  Nothing?
>>>>
>>>>
>>>> One other thing that I can see being useful occasionally is:
>>>>
>>>>     git rebase @{u}@{1} --onto @{u}
>>>>
>>>> which allows local commits to be replayed onto a rewritten upstream
>>>> branch.
>>>>
>>>> Although I agree with your side note below that people doing this 
>>>> may be
>>>> better off fetching and then updating their local branch, 
>>>> particularly
>>>> if @{1} is not the correct reflog entry for the upstream when they
>>>> created the branch.
>>>
>>>
>>> That's why after recognizing the fact the you can't find the branch
>>> point of a branch in Git, I decided to write patches to support the
>>> @{tail} shorthand, which is basically the point where the branch was
>>> created, or rebased to:
>>>
>>> https://github.com/felipec/git/commits/fc/base
>>>
>>> And if 'git rebase' was fixed to ignore the commits already in the
>>> rebased onto branch, almost always what you would want to do is 'git
>>> rebase @{tail} --onto @{upstream}'.
>>>
>> The use case that trips me up (i.e. doesn't fit the above) is when I 
>> have a
>> branch that may need rebasing on (onto) pu, or may need rebasing on 
>> master,
>> or next, depending on what others have been doing.
>
> Yes, so you would do:
>
> % git rebase --onto pu
>
> Which would be translated to:
>
> % git rebase @{tail} --onto pu
>
> What's the problem?
>
The 'problem' is (would be) that I don't yet know that I would need 
the --onto pu until I discover (how?) that the default rebase would 
result in conflicts.

>> As a Distributed VCS (i.e. others doing work independently), a rebase 
>> always
>> has the possibility that the world has moved on and one has to adapt 
>> to the
>> new world order by moving location (--onto somewhere new), not just 
>> fixing
>> up the house (patch conflicts). When the update order is unknown 
>> there is no
>> guaranteed solution (IIUC).
>
> Yeah, but almost always you want to rebase onto @{upstream}.

Yeah, but almost always you want to "check" first *before* starting. 
That is, 'git rebase --abort' should not be required from the (user's 
selected /git's) default invocation.

--
Philip Oakley 
