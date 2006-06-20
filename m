From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: wrong check condition in patch-delta.c?
Date: Tue, 20 Jun 2006 09:21:50 +0200
Message-ID: <20060620072150.GB26656@fiberbit.xs4all.nl>
References: <fcaeb9bf0606192332j5b2ee4b9ycf2c63c7b1820204@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 09:22:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsaYg-00077m-0P
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 09:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965112AbWFTHVx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 20 Jun 2006 03:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbWFTHVx
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 03:21:53 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:21698 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S965112AbWFTHVw
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 03:21:52 -0400
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.62)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1FsaYY-0006ym-Ge; Tue, 20 Jun 2006 09:21:50 +0200
To: Nguy???n =?iso-8859-1?Q?Th=E1i?= Ng???c Duy <pclouds@gmail.com>
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0606192332j5b2ee4b9ycf2c63c7b1820204@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22175>

On Tuesday June 20th 2006 Nguy???n Th=E1i Ng???c Duy wrote:

> While inspecting patch-delta.c, I encounter this:
>                       if (cp_off + cp_size < cp_size ||
>                           cp_off + cp_size > src_size ||
>                           cp_size > size)
>                               goto bad;
> "cp_off + cp_size < cp_size" doesn't make sense to me. Is it on purpo=
se?

It protects against possible overflow. Adding fixed length integers is
"wraparound" after all and discards the "carry" bit.
--=20
Marco Roeland
