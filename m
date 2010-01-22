From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCHv2] Make difftool.prompt fall back to mergetool.prompt
Date: Fri, 22 Jan 2010 13:24:13 -0800
Message-ID: <7B0478B5-CEE2-4207-8268-B0B338F88449@gmail.com>
References: <4B59D414.4020507@gmail.com> <7vr5pivx70.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (iPhone Mail 7D11)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 22:30:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYR4p-0005Q1-7A
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 22:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754287Ab0AVV3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 16:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754236Ab0AVV3y
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 16:29:54 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:52430 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754226Ab0AVV3y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 16:29:54 -0500
Received: by yxe17 with SMTP id 17so1398973yxe.33
        for <git@vger.kernel.org>; Fri, 22 Jan 2010 13:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=dcbs8Bnbx3jdctr5umct3+WjuLXwVvuqSWewsZj4PvY=;
        b=D7KKTFr0g1qruwK9Hr2o5wy8dfBDkOAaxPUnq5rgP3d0igRdSrlwHaP7iEOVLhfybM
         ukC2hHKEIHoTnJqrsgaXpretShawz9+ujhq2WUjZ2fKa3kI39m+BCDK0V0vYgVwQ8yTA
         tdOnZh1oUrx3TV5FfL20eU9DC/DAEuNwmdgFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:x-mailer:mime-version:subject:date:cc;
        b=rtWZTfJXu8K+FlgDW6obm8/4ZT07SDOKzklaaq+8FnJt55sTCNBZe0b3jKXSq99ggf
         paij5/GBapK7CNSy7HHwoQMiFx8wc/w0gjvtQzAcLf+B2Oak3yh0nY3kCvLgUMFbcXk0
         VWrcJ/2ldw/BG/XqGN7Fih4TKKWja8GEYVdAI=
Received: by 10.151.89.33 with SMTP id r33mr4821182ybl.290.1264195462900;
        Fri, 22 Jan 2010 13:24:22 -0800 (PST)
Received: from ?10.135.19.104? ([166.137.4.27])
        by mx.google.com with ESMTPS id 21sm934492ywh.1.2010.01.22.13.24.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Jan 2010 13:24:22 -0800 (PST)
In-Reply-To: <7vr5pivx70.fsf@alter.siamese.dyndns.org>
X-Mailer: iPhone Mail (7D11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137784>

On Jan 22, 2010, at 9:58 AM, Junio C Hamano <gitster@pobox.com> wrote:

> Sebastian Schuberth <sschuberth@gmail.com> writes:
>
>> The documentation states that "git-difftool falls back to git- 
>> mergetool
>> config variables when the difftool equivalents have not been  
>> defined".
>> Until now, this was not the case for "difftool.prompt".
>>
>> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
>
> David, does this look ok?  It seems to match the discussion between  
> you I
> saw yesterday, but just checking to make sure (if "yes" please Ack).

Acked-by: David Aguilar <davvid@gmail.com>

I would like to see a testcase to ensure we don't break it in the  
future, though.

Thanks Sebastian, Junio.

Sebastian, I you don't send a test I'll try to send one tonight.


>
> Is it Ok that today I see only this patch not two-patch series on the
> topic (iow, has the other patch been withdrawn)?  I didn't folow the
> discussion very closely.
>
> Thanks.
>
>> ---
>> git-difftool--helper.sh |    3 ++-
>> 1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
>> index 57e8e32..3438aba 100755
>> --- a/git-difftool--helper.sh
>> +++ b/git-difftool--helper.sh
>> @@ -12,7 +12,8 @@ TOOL_MODE=diff
>> # difftool.prompt controls the default prompt/no-prompt behavior
>> # and is overridden with $GIT_DIFFTOOL*_PROMPT.
>> should_prompt () {
>> -    prompt=$(git config --bool difftool.prompt || echo true)
>> +    prompt_merge=$(git config --bool mergetool.prompt || echo true)
>> +    prompt=$(git config --bool difftool.prompt || echo  
>> $prompt_merge)
>>    if test "$prompt" = true; then
>>        test -z "$GIT_DIFFTOOL_NO_PROMPT"
>>    else
>> -- 
>> 1.6.6.265.ga0f40
