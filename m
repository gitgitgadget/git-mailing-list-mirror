From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Feature idea : notes to track status of a commit, which remotes it is shared to
Date: Tue, 19 Feb 2013 11:13:19 +0100
Message-ID: <87bobgtxvk.fsf@pctrast.inf.ethz.ch>
References: <51234801.5050208@mildred.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Mildred Ki'Lya <mildred-ml@mildred.fr>
X-From: git-owner@vger.kernel.org Tue Feb 19 11:13:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7kCo-0001YM-KS
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 11:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758592Ab3BSKNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 05:13:24 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:7391 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932209Ab3BSKNW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 05:13:22 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Feb
 2013 11:13:16 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 19 Feb 2013 11:13:20 +0100
In-Reply-To: <51234801.5050208@mildred.fr> (Mildred Ki'Lya's message of "Tue,
	19 Feb 2013 10:38:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216595>

Mildred Ki'Lya <mildred-ml@mildred.fr> writes:

> The idea is to basically track automatically (in notes, either in the
> notes namespace or in another namespace) which repository/remote
> contains a commit. When doing git log, we'd see lines with each
> commit, something like:
>
> commit b044e6d0f1a1782820b052348ab0db314e2db3ca
> Author: Myself <myself@localhost.localdomain>
> Date:   Tue Nov 20 16:46:38 2012 +0100
>
>     This is the commit description
>
> Published on:
>     origin
>     git@git.host.com:pub/repo.git

The problem here is that doing this in notes is unreliable: you'd have
to identify all places where the set of "publishes" can change for any
commit, and update them there.

It's much easier, if a bit slower, to just run

  git branch -r --contains $commit

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
