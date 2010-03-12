From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [Improvement?] How do you switch branches in a bare repo?
Date: Fri, 12 Mar 2010 02:09:53 -0600
Message-ID: <b4087cc51003120009o7bd99609w996de02b732fbbd9@mail.gmail.com>
References: <4B99DEA2.6050104@uq.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 12 09:10:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npzwt-0007L7-Ml
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 09:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755656Ab0CLIKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 03:10:16 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:64829 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083Ab0CLIKO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 03:10:14 -0500
Received: by ey-out-2122.google.com with SMTP id 25so82883eya.19
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 00:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type;
        bh=m6nYiAaEjxSChI58XakQC8BVM05nfOi9tJGE11hS5TE=;
        b=PFfzOTpaixFZ7ZWbKFbqvCBIN87LsVK1Wre0Zj8cI5wSOT4w8m3UKy0nGuaEK2k5Xr
         mRslxte6kZaY3+UggK4Hvvk6uXYjw291uROLPy2eQcQNRRDMYz6xKDw5yux3E5spsOL9
         sxPruISbrft3bCcKGwFe/MD97TOoGBtnHfVGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=DuwGJYID9Ho335A50wJLU78ZFG/1wJ5Zrx2CUsxU7MxVORd3GsoO7dXKAxGtiKsB6v
         B/O8ENjfnsLLEZ2JinxoQKSV9i/k3Xv75IxS/JIH0zkWND1G/vfXex1CUQ8/VyiT2kdj
         IUWyjGXwTFHQ5sI+Mo9JCpb6zJDcZbn/G366k=
Received: by 10.213.100.165 with SMTP id y37mr238617ebn.71.1268381413436; Fri, 
	12 Mar 2010 00:10:13 -0800 (PST)
In-Reply-To: <4B99DEA2.6050104@uq.edu.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142033>

On Fri, Mar 12, 2010 at 00:26, Adam Nielsen <adam.nielsen@uq.edu.au> wrote:
> Hi all,
>
> I want to remove some commits (with git reset) from a bare repo, but they're
> not in the master branch and I can't figure out how to change branches:
>
> $ git checkout newbranch
> fatal: This operation must be run in a work tree

Commands like "git checkout" and "git reset" essentially operate on 2
aspects of a repository:

    (1) The repository's state.
    (2) The repository's working tree.

Is there any reason why these commands can't just operate on (1) in a
bare repository, thereby allowing users to use familiar commands to
get their work done?

The "git checkout" command in a bare repository should serve to select
on which branch other commands (like "git reset") operate, etc.

Michael Witten
