From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] tests: simplify "missing PREREQ" message
Date: Tue, 24 Aug 2010 12:16:02 +0200
Message-ID: <4C739BE2.5060200@viscovery.net>
References: <20100811014325.GA4169@burratino> <1281528278-15659-1-git-send-email-avarab@gmail.com> <20100824073410.GA5562@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 12:16:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnqYD-0008Fe-6U
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 12:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741Ab0HXKQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 06:16:10 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:54120 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754453Ab0HXKQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 06:16:09 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OnqY1-0005UL-3j; Tue, 24 Aug 2010 12:16:05 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id B83DF1660F;
	Tue, 24 Aug 2010 12:16:02 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.11) Gecko/20100711 Thunderbird/3.0.6
In-Reply-To: <20100824073410.GA5562@burratino>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154309>

Am 8/24/2010 9:34, schrieb Jonathan Nieder:
> @@ -417,8 +417,14 @@ test_skip () {
>  	fi
>  	case "$to_skip" in
>  	t)
> +		of_prereq=
> +		if test "$missing_prereq" != "$prereq"
> +		then
> +			of_prereq=" of $prereq"
> +		fi
> +
>  		say_color skip >&3 "skipping test: $@"
> -		say_color skip "ok $test_count # skip $1 (missing $missing_prereq of $prereq)"
> +		say_color skip "ok $test_count # skip $1 (missing $missing_prereq${of_prereq})"
>  		: true
>  		;;
>  	*)

While you are touching this area, would also fix messages like these:

ok 70 # skip set --path (missing  of )
ok 71 # skip get --path (missing  of HOMEVAR)
ok 72 # skip get --path copes with unset $HOME (missing  of )

which are due to GIT_SKIP_TESTS=t1300.7[012]

-- Hannes
