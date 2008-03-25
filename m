From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: [PATCH] shortlog: initialize nongit variable
Date: Tue, 25 Mar 2008 20:58:50 +0100
Message-ID: <2c6b72b30803251258j313e0d94qe290b8b7c7b377f0@mail.gmail.com>
References: <1206456377-2735-1-git-send-email-szeder@ira.uka.de>
	 <fcaeb9bf0803250839p721e1870l8fbc8715b3c6e7cb@mail.gmail.com>
	 <20080325160356.GC6506@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?SZEDER_G=E1bor?=" <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Mar 25 20:59:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeFJ7-0007bK-W4
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 20:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188AbYCYT6w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2008 15:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753029AbYCYT6w
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 15:58:52 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:36880 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250AbYCYT6v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Mar 2008 15:58:51 -0400
Received: by wr-out-0506.google.com with SMTP id c48so2445664wra.1
        for <git@vger.kernel.org>; Tue, 25 Mar 2008 12:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=vNxKKKW71wX2Ej3pObUYfuM0WKjPPyV7NeH1FdeS4WY=;
        b=a8L8G309BnRY86i0RZfHBa4Rnb8cRfNvSYj98tvMjuwfYLChHj/hCYH1i4ebemCu7k9/BEW+oRWaZSLxNlOZvHCTiqQHvjJ/xF/Kroff61RUCREsIPwO1gtCOdbANwk573lfL8+aGUwN8zFTdihANk2BiNZHQ/4cLPwUU+rLjJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O3S3j6CbeZx4XvcvbVkxwGXXKVf04JKcdHoBxJlFhx+NriDhz14J+liJ5e54HBxUt+snDk6qRUELOr6cCEQ8VL1lrdfgscfDopLYUv8EQl4UOwBNzhOFKhF7x7hEgRANcVc00JbTH8VgmqSv1FeIXdqNrEOT8kr7aCbbjrpu3XY=
Received: by 10.140.207.2 with SMTP id e2mr3715431rvg.104.1206475129987;
        Tue, 25 Mar 2008 12:58:49 -0700 (PDT)
Received: by 10.141.91.15 with HTTP; Tue, 25 Mar 2008 12:58:50 -0700 (PDT)
In-Reply-To: <20080325160356.GC6506@neumann>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78217>

2008/3/25 SZEDER G=E1bor <szeder@ira.uka.de>:
>  However, it might be better to let setup_git_directory_gently() set
>  *nongit_ok to 0 if we are in a git repository.  Patch appended.

As the one responsible for introducing this bug into shortlog, I can on=
ly agree.

>   builtin-bundle.c     |    2 +-
>   builtin-config.c     |    2 +-
>   builtin-diff-files.c |    2 +-
>   builtin-ls-remote.c  |    2 +-
>   git.c                |    2 +-
>   setup.c              |    8 ++++++++
>   6 files changed, 13 insertions(+), 5 deletions(-)

git grep reveals that builtin-{apply,diff}.c, help.c and var.c also
belongs on this list.

--=20
Jonas Fonseca
