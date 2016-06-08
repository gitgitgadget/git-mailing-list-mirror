From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH V2 3/3] strbuf: allow to use preallocated memory
Date: Wed, 8 Jun 2016 18:20:41 +0200
Message-ID: <575845D9.2010604@alum.mit.edu>
References: <20160606151340.22424-1-william.duclot@ensimag.grenoble-inp.fr>
 <20160606151340.22424-4-william.duclot@ensimag.grenoble-inp.fr>
 <xmqqvb1mxmk4.fsf@gitster.mtv.corp.google.com>
 <20160606203901.GA7667@Messiaen>
 <xmqqfusquedk.fsf@gitster.mtv.corp.google.com>
 <20160606225847.GA22756@sigill.intra.peff.net>
 <xmqqbn3dvr22.fsf@gitster.mtv.corp.google.com>
 <20160607090653.GA4665@Messiaen>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	Johannes.Schindelin@gmx.de, mh@glandium.org
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 18:21:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAgER-0005A8-Ht
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 18:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757564AbcFHQVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 12:21:23 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:44113 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757561AbcFHQVW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2016 12:21:22 -0400
X-AuditID: 1207440e-f07ff700000008c5-1f-575845fca86a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id BC.26.02245.CF548575; Wed,  8 Jun 2016 12:21:16 -0400 (EDT)
Received: from [192.168.69.130] (p548D6006.dip0.t-ipconnect.de [84.141.96.6])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u58GLD4J004486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 8 Jun 2016 12:21:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <20160607090653.GA4665@Messiaen>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsUixO6iqPvHNSLcYOc8HYvJG+6xWtxtyrDo
	utLNZNHQe4XZon95F5tF7+ReVosfLT3MFrsnX2J04PC42hzg8XT7FGaPDx/jPJ717mH0uHhJ
	2ePzJrkAtihum6TEkrLgzPQ8fbsE7ozrKzcxFtwVrGjoy21g/MnbxcjJISFgIvHw2V32LkYu
	DiGBrYwSS758ZoRwzjBJ9E9bxQ5SJSzgIvF2SSdLFyMHh4hAhsST+2EQNdOZJR5f/gDWzSxw
	ilFi9fM1rCANbAK6Eot6mplAbF4BbYk5S+ewgzSzCKhIrOyvBwmLCoRInF+3lRWiRFDi5Mwn
	LCA2J1Drv3nfmUFsZgE9iR3Xf7FC2PIS29/OYZ7AyD8LScssJGWzkJQtYGRexSiXmFOaq5ub
	mJlTnJqsW5ycmJeXWqRrrJebWaKXmlK6iRES7Hw7GNvXyxxiFOBgVOLhPaEXHi7EmlhWXJl7
	iFGSg0lJlHeJQ0S4EF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHeS45AOd6UxMqq1KJ8mJQ0B4uS
	OK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBC8nMKqFBItS01Mr0jJzShDSTBycIMO5pESKU/NS
	UosSS0sy4kERGV8MjEmQFA/QXkGQdt7igsRcoChE6ylGRSlx3j8uQAkBkERGaR7cWFgKe8Uo
	DvSlMG8JSDsPMP3Bdb8CGswENHj5kXCQwSWJCCmpBkbpKVNd2u4UTVhsGbBjZ5T2nyq3tZNb
	p1otefIgt2/GOYvITotrNuFz34Y8nycat1F7RlruZ41lJplPuxWembcKfrG52KST 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296809>

On 06/07/2016 11:06 AM, William Duclot wrote:
> [...]
> The "fixed" feature was aimed to allow the users to use strbuf with
> strings that they doesn't own themselves (a function parameter for
> example). From Michael example in the original mail:
> 
> void f(char *path_buf, size_t path_buf_len)
> {
>     struct strbuf path;
>     strbuf_wrap_fixed(&path, path_buf,
>     strlen(path_buf),
>     path_buf_len);
>     ...

I also thought that "fixed" strbufs would be useful in cases where you
*know* what size string you need and only want a strbuf wrapper because
it offers a lot of convenience functions. Nowadays we would do that
using something like

> static int feed_object(const unsigned char *sha1, int fd, int negative)
> {
> 	char buf[42];
> 
> 	if (negative && !has_sha1_file(sha1))
> 		return 1;
> 
> 	memcpy(buf + negative, sha1_to_hex(sha1), 40);
> 	if (negative)
> 		buf[0] = '^';
> 	buf[40 + negative] = '\n';
> 	return write_or_whine(fd, buf, 41 + negative, "send-pack: send refs");
> }

Instead, one could write

> static int feed_object(const unsigned char *sha1, int fd, int negative)
> {
> 	char buf[GIT_SHA1_HEXSZ + 2];
> 	struct strbuf line = WRAPPED_FIXED_STRBUF(buf);
> 
> 	if (negative && !has_sha1_file(sha1))
> 		return 1;
> 
> 	if (negative)
> 		strbuf_addch(&line, '^');
> 	strbuf_add(&line, sha1_to_hex(sha1), GIT_SHA1_HEXSZ);
> 	strbuf_addch(&line, '\n');
> 	return write_or_whine(fd, line.buf, line.len, "send-pack: send refs");
> }

* It's a little less manual bookkeeping, and thus less error-prone,
  than the current code.

* If somebody decides to add another character to the line but
  forgets to increase the allocation size, the code dies in testing
  rather than (a) overflowing the buffer, like the current
  code, or (b) silently becoming less performant, as if it used a
  preallocated but non-fixed strbuf.

* There's no need to strbuf_release() (which can be convenient in
  a function with multiple exit paths).

I don't know whether this particular function should be rewritten; I'm
just giving an example of the type of scenario where I think it could be
useful.

In a world without fixed strbufs, what would one use in this situation?

Michael
