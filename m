From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC] Add bad-branch-first option for git-bisect
Date: Mon, 24 Jan 2011 11:50:49 +0100
Message-ID: <4D3D5989.50903@viscovery.net>
References: <4D3CDDF9.6080405@intel.com> <AANLkTimUkv9+g_+wFcyGhwMjE9zYAKjMn32GL-WOVmoe@mail.gmail.com> <4D3D54D3.7040801@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"apenwarr@gmail.com" <apenwarr@gmail.com>
To: Shuang He <shuang.he@intel.com>
X-From: git-owner@vger.kernel.org Mon Jan 24 11:51:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhK0i-0001R0-Vv
	for gcvg-git-2@lo.gmane.org; Mon, 24 Jan 2011 11:51:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560Ab1AXKuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jan 2011 05:50:54 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:54496 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751416Ab1AXKuy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jan 2011 05:50:54 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PhK0Y-0001rk-7R; Mon, 24 Jan 2011 11:50:50 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id EB6431660F;
	Mon, 24 Jan 2011 11:50:49 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4D3D54D3.7040801@intel.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165445>

Am 1/24/2011 11:30, schrieb Shuang He:
> It's recursively applying bad branch first algorithm, not just constantly
> stick to first parent.
> Given this condition:
>     A -> B -> C -> D -> E -> F -> G -> H   (master)
>          \ a  -> b -> c -> d -> e /  (feature 1)
>               \ x -> y -> z/      (feature 2)
> start with H as bad commit, and A as good commit, if y is the target bad
> commit. bad-branch-first algorithm will do it like this:
>     1. In first round stick to master branch, so it will locate G as first
> bad commit
>     2. In second round stick to feature1 branch, then it will locate d as
> first bad commit
>     3. In third round stick to feature2 branch, then it will finally
> locate y as first bad commit
> So you could see, it's always sticking to branch where current bad commit sit

Ok, so you explain what your algorithm does.

But you did not illustrate your problem. The history above is ordinary,
somewhat branchy, has *ONE* commit that introduces a regression, and *NO*
commit that fixes the regression. But in your rationale you said something
about "feature1 is fixed just a moment later after feature2 branch is
created". How does this fit into the picture, where is the problem, and
how does your algorithm solve it?

-- Hannes
