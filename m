From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v2 2/3] t5601: add more test cases for IPV6
Date: Mon, 23 Feb 2015 06:36:40 +0100
Message-ID: <54EABC68.40308@web.de>
References: <54E8A9DD.7090908@web.de> <xmqq61atuysn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, lists@hcf.yourweb.de
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 23 06:37:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPliM-0007yX-Ax
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 06:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbbBWFht convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Feb 2015 00:37:49 -0500
Received: from mout.web.de ([212.227.17.12]:56242 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119AbbBWFht (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 00:37:49 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LvSU3-1XPnUQ0aLz-010Ze7; Mon, 23 Feb 2015 06:37:45
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <xmqq61atuysn.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:DStjrTa10TTNU/vMuxD6W/nBVq7yD2rhyymTJgVtwLn4FqCisdO
 OJxmsAIogOrSDx3FojMzdPu9DerGT2n1ZzCKWSZueBa8JW61r5zFdQU14Ge8AvRKSQ+4JAH
 S7aTbqEW2fqHU98sL6y3xtobKQus4jDWYEKICJNcToHU+j3Kp3L2U/Xg5JUhEe3seUMxYWS
 UIaPtmfKuUNnQBinK7C/Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264247>

On 02/23/2015 03:50 AM, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> @@ -359,7 +366,7 @@ done
>>   for repo in rep rep/home/project 123
>>   do
>>   	test_expect_success "clone [::1]:$repo" '
>> -		test_clone_url [::1]:$repo ::1 $repo
>> +		test_clone_url [::1]:$repo ::1 "$repo"
>>   	'
>>   done
> This change is somewhat a curious one.  Why quote the last
> occurrence of $repo but not the previous one?
The reason to quote is that
some shells replace ~ with $HOME, but not "~"
exactly here it seems not to be needed.
>
>> +for tuah in ::1 [::1] user@::1 user@[::1] [user@::1]
>> +do
>> +	euah=3D$(echo $tuah | tr -d "[]")
> What are tuah and euah, by the way?  Are they FLA for some phrases?
tuah =3D tested username and host
euah =3D expected username and host
