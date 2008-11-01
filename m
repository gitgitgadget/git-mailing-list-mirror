From: "Tom Preston-Werner" <tom@github.com>
Subject: Re: [PATCH] connect.c: add a way for git-daemon to pass an error back to client
Date: Fri, 31 Oct 2008 19:18:28 -0700
Message-ID: <b97024a40810311918sca49d02g2dac46ca73e0fd87@mail.gmail.com>
References: <b97024a40810311859t2e5a6102u31ad4480e7c75c03@mail.gmail.com>
	 <alpine.DEB.1.00.0811010316340.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 01 03:19:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw65a-0007RO-QN
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 03:19:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbYKACSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 22:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbYKACSa
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 22:18:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:6931 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267AbYKACSa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 22:18:30 -0400
Received: by nf-out-0910.google.com with SMTP id d3so681869nfc.21
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 19:18:28 -0700 (PDT)
Received: by 10.210.72.14 with SMTP id u14mr2805202eba.173.1225505908406;
        Fri, 31 Oct 2008 19:18:28 -0700 (PDT)
Received: by 10.210.117.11 with HTTP; Fri, 31 Oct 2008 19:18:28 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0811010316340.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99711>

On Fri, Oct 31, 2008 at 7:19 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> The cute trick with this is that even older clients would be able to
> display the error, albeit with a sort of funny message:
>
>        protocol error: expected sha/ref, got 'No matching repository.'

This is exactly what GitHub does right now with our custom Erlang
git-daemon. Try doing:

$ git clone git://github.com/mojombo/foo

and you'll get:

fatal: protocol error: expected sha/ref, got '
*********'

No matching repositories found.

*********'

This has cut down tremendously on the number of support requests we
get from new users. It would be nice to cut out the clutter from the
error message though.

Tom
