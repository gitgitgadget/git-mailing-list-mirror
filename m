From: Sandy Carter <sandy.carter@savoirfairelinux.com>
Subject: Re: [PATCH v2] status merge: guarentee space between msg and path
Date: Wed, 12 Mar 2014 16:08:56 -0400
Message-ID: <5320BED8.3040108@savoirfairelinux.com>
References: <1394555447-1805-1-git-send-email-sandy.carter@savoirfairelinux.com>	<1394580211-13383-1-git-send-email-sandy.carter@savoirfairelinux.com> <xmqqmwgvkyig.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 21:07:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNpQr-0001RY-Oy
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 21:07:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341AbaCLUHL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Mar 2014 16:07:11 -0400
Received: from mail.savoirfairelinux.com ([209.172.62.77]:56947 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbaCLUHK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 16:07:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E8D6710D7239;
	Wed, 12 Mar 2014 16:07:09 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pTdOEqowJ18v; Wed, 12 Mar 2014 16:07:09 -0400 (EDT)
Received: from [192.168.49.85] (mtl.savoirfairelinux.net [208.88.110.46])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id A0D9210D62C5;
	Wed, 12 Mar 2014 16:07:09 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <xmqqmwgvkyig.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243981>


Le 2014-03-12 15:28, Junio C Hamano a =C3=A9crit :
> Sandy Carter <sandy.carter@savoirfairelinux.com> writes:
>
>> Add space between how and one when printing status of unmerged data.
>> This fixes an appending of the how message when it is longer than 20=
,
>> such  is the case in some translations such as the french one where =
the
>> colon gets appended to the file:
>>      supprim=C3=A9 par nous :wt-status.c
>>      modifi=C3=A9 des deux c=C3=B4t=C3=A9s :wt-status.h
>> Additionally, having a space makes the file in question easier to se=
lect
>> in console to quickly address the problem. Without the space, the co=
lon
>> (and, sometimes the last word) of the message is selected along with=
 the
>> file.
>>
>> The previous french example should now print as, which is more prope=
r:
>>      supprim=C3=A9 par nous :      wt-status.c
>>      modifi=C3=A9 des deux c=C3=B4t=C3=A9s : wt-status.h
>>
>> try 2:
>> Add function so wt_status_print_unmerged_data() and
>> wt_status_print_change_data() make use of the same padding technique
>> defined as wt_status_status_padding_string()
>>
>> This has the additionnal advantage of aligning unmerged paths with p=
aths
>> of regular statuses.
>>
>> Signed-off-by: Sandy Carter <sandy.carter@savoirfairelinux.com>
>> ---
>>   t/t7060-wtstatus.sh         |  16 +++----
>>   t/t7506-status-submodule.sh |  18 ++++----
>>   t/t7508-status.sh           |  94 +++++++++++++++++++-------------=
-------
>>   t/t7512-status-help.sh      |  30 ++++++-------
>
> This is too noisy a patch to be reviewed.  I tried to resurrect
> Jonathan's fix from Dec 2013 and posted it elsewhere---does it work
> for you?

Seems fine except for the bit about returning _("bug"), which I brought=
 up.

Seems to do the same thing as my proposal without changing the alignmen=
t=20
of paths in of regular status output. No changes to tests necessary,=20
less noisy.

It works for me.

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
