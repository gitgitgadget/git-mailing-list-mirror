From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] Add a test for subtree rebase that loses commits
Date: Tue, 5 Jan 2016 09:47:55 +0100
Message-ID: <568B833B.4060001@web.de>
References: <1451968805-6948-1-git-send-email-greened@obbligato.org>
 <1451968805-6948-2-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, john@keeping.me.uk,
	sandals@crustytoothpaste.net, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 09:48:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGNIF-0001AF-HE
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 09:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbcAEIsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 03:48:36 -0500
Received: from mout.web.de ([212.227.17.12]:54748 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751104AbcAEIse (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 03:48:34 -0500
Received: from macce.local ([79.223.105.199]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MGRZc-1aTcoY0QBU-00DE3m; Tue, 05 Jan 2016 09:47:58
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.0
In-Reply-To: <1451968805-6948-2-git-send-email-greened@obbligato.org>
X-Provags-ID: V03:K0:uh8l5MSlGD/glbOsiGrtmaDQXbagCiDsefRjPP6f+YzOpHkj0mn
 p8AFwCEve1JHOLZgGQk0MiFh5jl+5mGsI2PtQoeG+yEOyfQMh7khvsK9R85aWm2VxKdV7fc
 P3hlvf/WijjVSuHiV7+BgZP2jvRsQIzssDkwwW6CcDtFItPgX9nesF6e5of5Ky+eCR2M+HE
 b3Gj2eTGoJCoeCzm7BS5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2ymOGtv/i7I=:p/R48Z/SrHg6mL3IdVLmvL
 +593GmqbzAtZJS4yMp/NkBRfwEwFuxXisg8t+aMFTZbfi01aviVsQtqQ6V/83Dqk+TUyLY1fR
 WiGQez0iw1M4fzETEuRoa2AaXttUgWxYuY92JtsvdEheYpA3rqg3ABuqhHBHawkqSEoHgZbyo
 JtQr4/Po0ZcouR9wNwHnbOR8V/Gy4qRy+am67aNJKRdAnySkRARjJ6rrZ3Qrt4XKh89EN7vj7
 fi56aQvE7HD40XN629BkSouHZSV5Bq3fMHRTLTGz9XLNJE8n3Hv66sC55UucYxxA+PWoTNQ9w
 o1dRPjNBewXWERl2EN98Dd/9Qw8VVaIwN4VB58/o3sc0R/mAhvE9pEos2u3JfwSR9fVh0i7lG
 GLHU3nflzhIel3YEiMmr9iUTxPvnys5LTvEZxCI3b1gK6t4RfxzD1LZC+iUnn1/iS6jZ5ccu7
 mL87GwBGuU1DQaRGOurf7W/8N+AdhLBZqgSRnBNzBAx64hTgwOiMOwumFvL9WFBzMJa8TjwHm
 PqbB24ZAx+5YTdR1DGEAWXcsXk8hgVqsSayDCcpel2VlCznE29J7wUVCbrSwvdUzzOJrv+4LM
 DUG1lzaFx2/5KCSE1VvSM3qTebcxZ4SfhBS7qb7jvl/lNg6KJgviTatnKlEm8yZs2Ytx7Kixh
 gu//VzyfKfyW9pl8Be8X0fPv9WgPzyB0lYLzAigPTa8CP5KrIQLJKtcmcqe2A1ZQIsiWDLkMZ
 HBRP3bxZmM31szeYx3lSz8sD9PumU7+4e1d/YJ3eXYK3rwACi2QsUweP24T9dK3EvsE0d9St 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283367>

Need to drop
David Greene <greened@obbligato.org>
from List, no MX record

On 2016-01-05 05.40, David Greene wrote:
> From: "David A. Greene" <greened@obbligato.org>
> 
> This test merges an external tree in as a subtree, makes some commits
> on top of it and splits it back out.  In the process the added commits
> are lost.  This is marked to expect failure so that we don't forget to
> fix it.
> 
> Signed-off-by: David A. Greene <greened@obbligato.org>
> ---
>  t/t3427-rebase-subtree.sh | 68 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100755 t/t3427-rebase-subtree.sh
> 
> diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
> new file mode 100755
> index 0000000..7eb28ab
> --- /dev/null
> +++ b/t/t3427-rebase-subtree.sh
> @@ -0,0 +1,68 @@
> +#!/bin/sh
> +
> +test_description='git rebase tests for -Xsubtree
> +
> +This test runs git rebase and tests the subtree strategy.
> +'
> +. ./test-lib.sh
> +
> +addfile() {
> +    name=$1
> +    echo $(basename ${name}) > ${name}
> +    ${git} add ${name}
> +    ${git} commit -m "Add $(basename ${name})"
> +}
> +
> +check_equal()
> +{
> +	test_debug 'echo'
> +	test_debug "echo \"check a:\" \"{$1}\""
> +	test_debug "echo \"      b:\" \"{$2}\""
> +	if [ "$1" = "$2" ]; then
> +		return 0
> +	else
> +		return 1
> +	fi
> +}
> +
> +last_commit_message()
> +{
> +	git log --pretty=format:%s -1
> +}
> +
> +test_expect_success 'setup' '
> +	test_commit README &&
> +	mkdir files &&
When cd'ing into a directory,
we need to do it in a sub-shell:
> +	cd files &&
> +	git init &&
> +	test_commit master1 &&
> +	test_commit master2 &&
> +	test_commit master3 &&
> +	cd .. &&
	mkdir files &&
	(
	cd files &&
	git init &&
	test_commit master1 &&
	test_commit master2 &&
	test_commit master3
	)


(And similar below)
> +	test_debug "echo Add project master to master" &&
> +	git fetch files master &&
> +	git branch files-master FETCH_HEAD &&
> +	test_debug "echo Add subtree master to master via subtree" &&
> +	git read-tree --prefix=files_subtree files-master &&
> +	git checkout -- files_subtree &&
> +	tree=$(git write-tree) &&
> +	head=$(git rev-parse HEAD) &&
> +	rev=$(git rev-parse --verify files-master^0) &&
> +	commit=$(git commit-tree -p ${head} -p ${rev} -m "Add subproject master" ${tree}) &&
> +	git reset ${commit} &&
> +	cd files_subtree &&
> +	test_commit master4 &&
> +	cd .. &&
> +	test_commit files_subtree/master5
> +'
> +
> +# Does not preserve master4 and master5.
> +test_expect_failure 'Rebase default' '
> +	git checkout -b rebase-default master &&
> +	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
> +	git commit -m "Empty commit" --allow-empty &&
> +	git rebase -Xsubtree=files_subtree  --preserve-merges --onto files-master master &&
> +	check_equal "$(last_commit_message)" "files_subtree/master5"
> +'
> +
> +test_done
> 
