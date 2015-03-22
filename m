From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 4/5] Add tests for git-log --merges=show|hide|only
Date: Sun, 22 Mar 2015 20:57:19 +0100
Message-ID: <550F1E9F.40801@web.de>
References: <1427048921-28677-1-git-send-email-koosha@posteo.de> <1427048921-28677-4-git-send-email-koosha@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Koosha Khajehmoogahi <koosha@posteo.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 20:57:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZm04-0002pp-Et
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 20:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbbCVT51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 15:57:27 -0400
Received: from mout.web.de ([212.227.17.11]:59278 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751789AbbCVT51 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 15:57:27 -0400
Received: from birne.local ([217.211.68.12]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0Lmu2K-1ZAB5T3vie-00h4y5; Sun, 22 Mar 2015 20:57:24
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <1427048921-28677-4-git-send-email-koosha@posteo.de>
X-Provags-ID: V03:K0:6CRKPLOf9d9ALMR0lcmrZhG/X8YFk0ptZfIX0JyCB9DTh8ngGbM
 ZD6znTTG7byfLU3EDCFAX8cydc/yqDbl3dyVfgrySmrGc2LSKxdiGLhoAgTgnZIle45cMp0
 T+2HOm8tiZS15HDdr9KuXk12+zxnmQ4fnq6rpCgOOw5HeGTc1E1G4wktph9zb02uVcaAxeC
 BYZj0z3IvzS8dmN4SXbEw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266088>

On 22.03.15 19:28, Koosha Khajehmoogahi wrote:
> Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>
> ---
>  t/t4202-log.sh | 141 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 141 insertions(+)
> 
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 5f2b290..ab6f371 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -428,6 +428,147 @@ cat > expect <<\EOF
>  * initial
>  EOF
>  
> +cat > only_merges <<EOF

- please no space after the ">"
- please add the && at the end of the line:
cat >only_merges <<EOF &&
(And the same further down)

> +test_expect_success 'log with config log.merges=show' '
> +	git config log.merges show &&
Indent with TAB is good
> +    git log --pretty=tformat:%s >actual &&
but indent with 4 spaces not ideal, please use a TAB as well.
> +	test_cmp both_commits_merges actual &&
> +    git config --unset log.merges
Do we need the unset here?
The log.merges is nicely set up before each test case, so can we drop the unset lines ?
(Or do I miss something ?)
