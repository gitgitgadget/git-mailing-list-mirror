From: Chhatoi Pritam Baral <chhatoipritam@gmail.com>
Subject: Re: [PATCH v3] t7012: Implement test for git-checkout
Date: Wed, 30 Mar 2016 18:59:45 +0530
Message-ID: <56FBD4C9.7080904@gmail.com>
References: <56F6BADF.4000005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 15:31:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alGDJ-00046T-Dy
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 15:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785AbcC3NbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 09:31:08 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33406 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890AbcC3NbC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 09:31:02 -0400
Received: by mail-pf0-f196.google.com with SMTP id x3so7262188pfb.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 06:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=GbABE9MTwPzXS7AiDKTyieIvqoar5OJ++0/yhkziwrk=;
        b=DxI7wAWKrdHJInxw3tPYpLYc3ldSTSFrYN1uAGZ8gymrfaL8oNJrkydm5BAGpdYXqK
         pmZZBI59IjUYcZvCln7S4IY6t90B1Hoad1382QTNXJlAWrsy+1k0i+KJwaL64nyKj6Ti
         ZslBt/F8T1OAIy22XHimdRHr7N42XVoLl3TRfV5r4IMYR//jbN48kZH7tU7mV5JIAiN+
         p6+ZaEGK7wxiz61ba0ddjhtodKhU10vReETKfMaBHaiEZx5XHl1bJioozFrfA2Qij4F9
         FEeums1tB2/iwMnF672S4ZEvl8nVXJanYA13UbMtyb/tOz3Z5p7v5+IjEl82Dv8fr8YQ
         Dtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=GbABE9MTwPzXS7AiDKTyieIvqoar5OJ++0/yhkziwrk=;
        b=ESgWepC593urxFoqGW9PbC5Nigw3yTQ5TYlJ7d3PBqwhYyrt3JqFYsgJOfkr+1IdIR
         8ARbc8UOewsoUDFFTGBGLT2IkqEwRnys4WsDmMvJDRa5uczTNarY0cWcHyANFP7NxwTB
         96SpiMohMzLnluk0rZKovhp3Q3QzVCBZwO8x1NmL3zzDvZ0Ll7z9UKk6N3TPrjT36dG3
         xUooniRm7EavgJ83cvvzESO/ySmw2N9AczTsonAxBd64Z9tB7B36WUAgOOSf1pGUuV3z
         fUFF3EHPyeA5zNhJ468wLTFTk3NK2DCrsESHCO9Z2wgmr1RscuhRKXZaZkrAwVEB20Vs
         Am2A==
X-Gm-Message-State: AD7BkJKFUnFqHZmi0mzAgsBqFohGxIgvS/agp0quNHxE/SZAUlmPCuRZzjj/cVp+ilWiUA==
X-Received: by 10.98.64.144 with SMTP id f16mr13047209pfd.159.1459344660943;
        Wed, 30 Mar 2016 06:31:00 -0700 (PDT)
Received: from [0.0.0.0] ([128.199.85.127])
        by smtp.gmail.com with ESMTPSA id r88sm6180543pfi.9.2016.03.30.06.30.59
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2016 06:31:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <56F6BADF.4000005@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290305>

Forgot to mention in the previous message, this is a microproject
for my GSoC '16 application.

(Is that redundant to mention after v1 and v2? )

On 03/26/2016 10:07 PM, Chhatoi Pritam Baral wrote:
> Previously a TODO; add a test for git-checkout skipping a
> file with the skip-worktree bit set.
>
> Signed-off-by: Chhatoi Pritam Baral <chhatoipritam@gmail.com>
> ---
>
> Replaced test_must_fail around grep with '!', as suggested by Eric.
>
>  t/t7012-skip-worktree-writing.sh | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/t/t7012-skip-worktree-writing.sh
> b/t/t7012-skip-worktree-writing.sh
> index 9ceaa40..276f076 100755
> --- a/t/t7012-skip-worktree-writing.sh
> +++ b/t/t7012-skip-worktree-writing.sh
> @@ -141,6 +141,16 @@ test_expect_success 'git-clean, dirty case' '
>  #TODO test_expect_failure 'git-apply removes file' false
>  #TODO test_expect_failure 'git-mv to skip-worktree' false
>  #TODO test_expect_failure 'git-mv from skip-worktree' false
> -#TODO test_expect_failure 'git-checkout' false
> +
> +test_expect_success 'git-checkout ignores skip-worktree file' '
> +	echo >1 &&
> +	git commit -m "Add files" &&
> +	echo dirty >1 &&
> +	echo dirty >2 &&
> +	git update-index --skip-worktree 1 &&
> +	git checkout -- . &&
> +	grep -q dirty 1 &&
> +	! grep -q dirty 2
> +'
>   test_done
