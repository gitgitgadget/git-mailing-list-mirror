From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] git-diff: Add --staged as a synonym for --cached.
Date: Mon, 10 Nov 2008 23:04:42 -0500
Message-ID: <32541b130811102004n54a47331v48ba8d299039897f@mail.gmail.com>
References: <1225296936-1357-1-git-send-email-dsymonds@gmail.com>
	 <20081029164253.GA3172@sigill.intra.peff.net>
	 <ee77f5c20810290950k6d7acfcbt90b6280c290bd532@mail.gmail.com>
	 <alpine.DEB.1.00.0810291804400.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	 <20081029171122.GA12167@sigill.intra.peff.net>
	 <20081102123519.GA21251@atjola.homenet>
	 <7vljw2yo93.fsf@gitster.siamese.dyndns.org>
	 <20081103071420.GD10772@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"David Symonds" <dsymonds@gmail.com>, git@vger.kernel.org,
	"Stephan Beyer" <s-beyer@gmx.net>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 11 05:06:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzkVr-000696-LQ
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 05:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961AbYKKEEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 23:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753926AbYKKEEo
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 23:04:44 -0500
Received: from hs-out-0708.google.com ([64.233.178.242]:24887 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539AbYKKEEn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 23:04:43 -0500
Received: by hs-out-0708.google.com with SMTP id 4so1223586hsl.5
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 20:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=dFtz/ApxyhmrXxsdy0H5Tnfpi0YcyxXUIqxmh1Xr14s=;
        b=ed4w7q0Gxbk19163KUveVweZCUluaVSuI1Bb97CkV5tE4zdX4E8rWWW2kqffc8MqoU
         l+KlQonzaUZj4N/3cl7ZCJP0vvOVTNkJmY86+BaWfRvekSuX1EvkXUQ6lFFWugKzviuG
         b3YJqNnpIyVLVzQVuL5K4mhxv99VctTHA02EQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=LPgFz4L83Gp5kNOVd7LOAznIv8CnI3T5ldWWubPK5JcyiRDLI5k/Oqh6QFzo3a/Qoj
         A5bJPaCrZknkDFBDRHSowUg1cB+USYxTLJOc3gKk9usvlm0nhslF8oTvsN1gI0yKy7H9
         s+gQxkHuijpSQkWjSefz2PLkGAlG1on/EKlLM=
Received: by 10.150.228.12 with SMTP id a12mr3934700ybh.99.1226376282197;
        Mon, 10 Nov 2008 20:04:42 -0800 (PST)
Received: by 10.150.98.19 with HTTP; Mon, 10 Nov 2008 20:04:42 -0800 (PST)
In-Reply-To: <20081103071420.GD10772@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100614>

On Mon, Nov 3, 2008 at 2:14 AM, Jeff King <peff@peff.net> wrote:
> So "git diff --staged", while it makes sense to us (since we are asking
> "what is staged"), is not consistent with the discussed rules. In
> particular:
>
>  1. It operates on just the "stage" and not the working tree, so it
>     should be "--staged-only". But the only there is nonsensical.
>
>  2. The default is _already_ operating on the staging area, so you are
>     really switching up the working tree for the HEAD in what you are
>     diffing. So in that sense, it doesn't convey the change in
>     operation very well.
>
> And I am not proposing a change here (except to perhaps "git diff
> --staged" instead of "--cached"). Just pointing out that it does not
> follow the "--staged operates on both, --staged-only operates on just
> the index" rule.
>
> Hrm. For that matter, grep is a bit different, too. Since I would expect
> "git grep --staged" to find only staged things, not things in both the
> working tree and the index. So perhaps there is a difference between
> commands that modify and commands that inspect.

Speaking just for myself, I would find this all a lot less confusing
if "staged" were a refspec of some sort, not an option at all.

   git diff HEAD..STAGED
   git diff STAGED..WORKTREE
   git grep pattern STAGED HEAD sillybranch WORKTREE ^ignorebranch --
path/to/files

git-rev-parse already gives us a nice syntax for including/excluding
particular trees as much as we like; the only problem is you can't
talk about the work tree or index as if they were revisions.

Have fun,

Avery
