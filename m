From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: problem with merging notes.
Date: Sun, 11 Mar 2012 19:37:12 +0100
Message-ID: <4F5CF0D8.8080904@elegosoft.com>
References: <87boo3m50x.fsf@zancas.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: David Bremner <david@tethera.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 19:38:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6nfE-00025d-LG
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 19:38:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753857Ab2CKSif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Mar 2012 14:38:35 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:45777 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753841Ab2CKSif (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2012 14:38:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 50225DE79B;
	Sun, 11 Mar 2012 19:38:34 +0100 (CET)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1kdj-MI0yFnp; Sun, 11 Mar 2012 19:38:34 +0100 (CET)
Received: from [192.168.1.101] (e178171008.adsl.alicedsl.de [85.178.171.8])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 15DF9DE78F;
	Sun, 11 Mar 2012 19:38:34 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120217 Thunderbird/10.0.2
In-Reply-To: <87boo3m50x.fsf@zancas.localnet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192820>

On 03/11/2012 06:17 PM, David Bremner wrote:
> tmpdir=$(mktemp -d)
> cd $tmpdir
> git init
> git commit --allow-empty -m'empty commit'
> git notes add -m 'foo' HEAD
> git notes --ref=other add -m 'bar' HEAD 
> git notes merge refs/notes/other
> cd .git/NOTES_MERGE_WORKTREE
> echo "foo\nbar\n"> $(git rev-parse HEAD)
> git notes merge --commit

cd back to your worktree *before* you call
"git notes merge --commit" and it will work as expected.

Apparently, there's some path issue and git notes just
continues doing half of its job. I'll check later.

> cd ../..
> git notes list | wc -l

Thanks.
