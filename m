From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Print conflict details with the new infrastructure (bug #11181)
Date: Tue, 2 Dec 2008 16:43:59 +0100
Message-ID: <20081202154359.GB19967@diana.vm.bytemark.co.uk>
References: <20081202144045.24372.69278.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 16:45:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7XRA-0000db-AI
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 16:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbYLBPoG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Dec 2008 10:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbYLBPoE
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 10:44:04 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1330 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbYLBPoD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 10:44:03 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1L7XPr-0006EV-00; Tue, 02 Dec 2008 15:43:59 +0000
Content-Disposition: inline
In-Reply-To: <20081202144045.24372.69278.stgit@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102147>

On 2008-12-02 14:40:45 +0000, Catalin Marinas wrote:

> The patch modifies the IndexAndWorkTree.merge() function to display
> pass the conflict information (files) when raising an exception. The
> logic is similar to the one in the old infrastructure.

Good. But

>          if self.__error:
> -            out.error(self.__error)
> +            error_lines =3D self.__error.split('\n')
> +            out.error(*error_lines)

this feels like something of a hack. Wouldn't it be cleaner to modify
MergeConflictException to hold e.g. the set of conflicting filenames,
and let it have a method that returned a list of lines? No biggie,
though.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
