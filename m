From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/7] Clean up stripspace a bit, use strbuf even more.
Date: Tue, 18 Sep 2007 14:12:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709181411200.28586@racer.site>
References: <1190074008617-git-send-email-krh@redhat.com>
 <1190074014548-git-send-email-krh@redhat.com> <11900740142347-git-send-email-krh@redhat.com>
 <11900740153845-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1650798537-1190121138=:28586"
Cc: git@vger.kernel.org
To: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 15:13:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXct8-0005G3-2y
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 15:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778AbXIRNNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 09:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754735AbXIRNNI
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 09:13:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:47353 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754545AbXIRNNG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 09:13:06 -0400
Received: (qmail invoked by alias); 18 Sep 2007 13:13:04 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp002) with SMTP; 18 Sep 2007 15:13:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/dqTFmP+zd7RZOK6UD3V+c9hP4nDC2fqQadZFetv
	89ls8ZnetPDIpS
X-X-Sender: gene099@racer.site
In-Reply-To: <11900740153845-git-send-email-krh@redhat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58602>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1650798537-1190121138=:28586
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

I really like your patch, except for this:

On Mon, 17 Sep 2007, Kristian Høgsberg wrote:

> diff --git a/builtin.h b/builtin.h
> index 03ee7bf..d6f2c76 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -7,7 +7,6 @@ extern const char git_version_string[];
>  extern const char git_usage_string[];
>  
>  extern void help_unknown_cmd(const char *cmd);
> -extern size_t stripspace(char *buffer, size_t length, int skip_comments);
>  extern int write_tree(unsigned char *sha1, int missing_ok, const char *prefix);
>  extern void prune_packed_objects(int);
>  
> diff --git a/strbuf.h b/strbuf.h
> index 21fc111..5960637 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -98,4 +98,6 @@ extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
>  
>  extern void read_line(struct strbuf *, FILE *, int);
>  
> +extern void stripspace(struct strbuf *buf, int skip_comments);
> +
>  #endif /* STRBUF_H */

If you do that, you have to move the function "stripspace" to strbuf.c, 
too...

Ciao,
Dscho

--8323584-1650798537-1190121138=:28586--
