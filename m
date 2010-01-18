From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Unmodified submodules shows up as dirty with 1.6.6.443.gd7346
Date: Mon, 18 Jan 2010 21:50:03 +0100
Message-ID: <4B54C97B.1050008@web.de>
References: <4B547EA6.5070203@isy.liu.se> <8c9a061001180802t5ec0d389j2cae9f1771130c36@mail.gmail.com> <4B549254.5090206@isy.liu.se> <7vr5pnqqem.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Mon Jan 18 21:56:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWydt-0004f3-0V
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 21:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754474Ab0ARUz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 15:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754272Ab0ARUz5
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 15:55:57 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:34561 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693Ab0ARUz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 15:55:56 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 34B5D13C4B21D;
	Mon, 18 Jan 2010 21:55:55 +0100 (CET)
Received: from [80.128.74.224] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NWyY1-00032C-00; Mon, 18 Jan 2010 21:50:05 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <7vr5pnqqem.fsf@alter.siamese.dyndns.org>
X-Provags-ID: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137404>

Am 18.01.2010 18:22, schrieb Junio C Hamano:
> I am suspecting that your "these files ... are named differently on
> different systems" may fall into the same category.  Your build may not
> produce "frotz.linux" when compiled on a FreeBSD box (and "frotz.fbsd" on
> a Linux box), but would it hurt more than it helps to list them in the
> same .gitignore to cover both?

If you keep source directories separate from directories for compiler
output you can easily simplify your .gitignore by negating it. So
instead of putting a line into the .gitignore for every file type you
do /not/ want, exclude everything in the build directory and add
exceptions for the files you /do/ want to track.

Then a .gitignore could look like this for building with VC6, VC8 and
Makefile based build systems:

path/to/build/directory/*
!*.dsw
!*.dsp
!*.sln
!*.vcproj
!Makefile
