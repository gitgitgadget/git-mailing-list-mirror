From: Karl Wiberg <kha@treskal.com>
Subject: Re: [StGit PATCH v2 3/6] stg mail: make __send_message do more
Date: Wed, 2 Dec 2009 08:03:51 +0100
Message-ID: <b8197bcb0912012303i3bd1061fhdb391de096996a27@mail.gmail.com>
References: <20091202003503.7737.51579.stgit@bob.kio>
	 <20091202004616.7737.60382.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: catalin.marinas@gmail.com, git <git@vger.kernel.org>
To: Alex Chiang <achiang@hp.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 08:04:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFjFm-0008Pp-Ua
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 08:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542AbZLBHDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 02:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752311AbZLBHDr
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 02:03:47 -0500
Received: from mail1.space2u.com ([62.20.1.135]:53421 "EHLO mail1.space2u.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036AbZLBHDr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 02:03:47 -0500
Received: from mail-bw0-f227.google.com (mail-bw0-f227.google.com [209.85.218.227])
	(authenticated bits=0)
	by mail1.space2u.com (8.14.3/8.14.3) with ESMTP id nB273k3V014657
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NOT)
	for <git@vger.kernel.org>; Wed, 2 Dec 2009 08:03:46 +0100
Received: by bwz27 with SMTP id 27so4112235bwz.21
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 23:03:52 -0800 (PST)
Received: by 10.204.35.12 with SMTP id n12mr6645905bkd.147.1259737431961; Tue, 
	01 Dec 2009 23:03:51 -0800 (PST)
In-Reply-To: <20091202004616.7737.60382.stgit@bob.kio>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134308>

Just pointing out a couple of Python tricks you might've wanted to
use. No need to update the patch, though.

On Wed, Dec 2, 2009 at 1:46 AM, Alex Chiang <achiang@hp.com> wrote:

> +        (patch_nr, total_nr) = (args[1], args[2])

Can be written as

  (patch_nr, total_nr) = args[1:3]

or, if args[2] is the last element of the list (which it isn't in this
case?),

  (patch_nr, total_nr) = args[1:]

> +    for (p, n) in zip(patches, range(1, total_nr + 1)):
> +        msg_id = __send_message('patch', tmpl, options, p, n, total_nr, ref_id)

Can be written as

  for (n, p) in enumerate(patches):

if you use n + 1 instead of n in the loop body.

-- 
Karl Wiberg, kha@treskal.com
   subrabbit.wordpress.com
   www.treskal.com/kalle
