From: "Dan McGee" <dpmcgee@gmail.com>
Subject: Re: [PATCH] git-format-patch(1)- add note about creating patch for single commit
Date: Sun, 19 Oct 2008 00:26:35 -0500
Message-ID: <449c10960810182226t5e2ae1ay4b53656a7cac4606@mail.gmail.com>
References: <1224392084-12956-1-git-send-email-dpmcgee@gmail.com>
	 <7v1vyd9n3d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 19 07:28:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrQqE-0002PG-DW
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 07:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbYJSF0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 01:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbYJSF0i
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 01:26:38 -0400
Received: from rv-out-0708.google.com ([209.85.198.242]:15882 "EHLO
	rv-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbYJSF0i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 01:26:38 -0400
Received: by rv-out-0708.google.com with SMTP id k29so1800764rvb.0
        for <git@vger.kernel.org>; Sat, 18 Oct 2008 22:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=EXvL+E4ORqfhYcfQANDtFQ3m6o+F2Kq+E8uJW6BvYvw=;
        b=Bsgxu83D05uvKF/MUhLIkGZbmTKCLCBTyRrivqpNJy1TCRLzQvgEzy4Qw2AxSgM3mh
         XCdyfMGX8KRGGehyzw8wlHBRKyOKH72+GP9/hCfEtJfpB/u66Whm14d1pWlN54WIINzw
         DyNBsFEUzg790N1EbxDch69tuds5zttQzGHIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=IcYDoDVS4bQmAmFfUVfszy23PWmBxeGuR6YYfF+v+qR6XTT/Djk6IT1plgDTi2Bd5A
         RKFEEZv423F7+Q9evpNhva/Wez2Y6Zxg1ZyBYeHpeGX+EG/u1Y+ysn0es/+H7MRkeGzo
         XTqOevALeNi+7QxMIEvp4lPWyLjlommK/gDkA=
Received: by 10.141.28.4 with SMTP id f4mr3817853rvj.35.1224393995171;
        Sat, 18 Oct 2008 22:26:35 -0700 (PDT)
Received: by 10.141.51.6 with HTTP; Sat, 18 Oct 2008 22:26:35 -0700 (PDT)
In-Reply-To: <7v1vyd9n3d.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98592>

On Sun, Oct 19, 2008 at 12:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Dan McGee <dpmcgee@gmail.com> writes:
>
>> Signed-off-by: Dan McGee <dpmcgee@gmail.com>
>> ---
>>
>> I thought this would be helpful because it took me the beter part of an hour
>> to find a solution instead of specifying C~1..C or other crazy things. The
>> current documentation just leaves you hanging when what you really want is
>> just one formatted patch.
>>
>> If there any suggestions on better wording, feel free to resubmit or whatever-
>> I just felt like this should be documented somewhere.
>>
>>  Documentation/git-format-patch.txt |    4 +++-
>>  1 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
>> index adb4ea7..8518c33 100644
>> --- a/Documentation/git-format-patch.txt
>> +++ b/Documentation/git-format-patch.txt
>> @@ -46,7 +46,9 @@ applies to that command line and you do not get "everything
>>  since the beginning of the time".  If you want to format
>>  everything since project inception to one commit, say "git
>>  format-patch \--root <commit>" to make it clear that it is the
>> -latter case.
>> +latter case.  If you want to format only a single commit, say "git
>> +format-patch <commit>^!" (which excludes all parent revisions of the
>> +specified commit).
>>
>>  By default, each output file is numbered sequentially from 1, and uses the
>>  first line of the commit message (massaged for pathname safety) as
>
> Heh, a more natural way to say that is:
>
>        git format-patch -1 $that_one
>
> That uses the first option described in the documentation:
>
>        -<n>::
>                Limits the number of patches to prepare.

Wow, had no idea about that option. :)

Given that I didn't even notice this option when I did go to the
manpage, what if my above change was instead reworked a bit:
>> +latter case.  If you want to format only a single commit, say "git
>> +format-patch -1 <commit>" .
