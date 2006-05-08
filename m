From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: (patch) calloc->xcalloc in read-cache.c
Date: Mon, 8 May 2006 21:01:40 +0300
Message-ID: <f36b08ee0605081101w3dc3a60cof5a524e9b4a3f555@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon May 08 20:02:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdA3E-0000Yv-Ez
	for gcvg-git@gmane.org; Mon, 08 May 2006 20:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbWEHSBl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 14:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWEHSBl
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 14:01:41 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:36213 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932475AbWEHSBl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 May 2006 14:01:41 -0400
Received: by py-out-1112.google.com with SMTP id f28so1359333pyf
        for <git@vger.kernel.org>; Mon, 08 May 2006 11:01:40 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=erDxap0cKifOt7s/55mWQ6I4X+2V81+M+kr+adyyfq8yjLfdFnnl2u9qmfeArjc+HZMuxzg4CnSlbu9uGMaQnIy/OKZGG0bzyIhZxOo3VVytlGTChHEZvHh9FUjiEUYM4uZhU7ouNLyVdycsBYzoxN3MJAkbTTnnajvYsJWjiLI=
Received: by 10.35.43.10 with SMTP id v10mr134263pyj;
        Mon, 08 May 2006 11:01:40 -0700 (PDT)
Received: by 10.35.96.18 with HTTP; Mon, 8 May 2006 11:01:40 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19773>

--- read-cache.c.000    2006-05-08 15:13:57.000000000 +0000
+++ read-cache.c        2006-05-08 15:15:35.000000000 +0000
@@ -557,7 +557,7 @@

        active_nr = ntohl(hdr->hdr_entries);
        active_alloc = alloc_nr(active_nr);
-       active_cache = calloc(active_alloc, sizeof(struct cache_entry *));
+       active_cache = xcalloc(active_alloc, sizeof(struct cache_entry *));

        offset = sizeof(*hdr);
        for (i = 0; i < active_nr; i++) {

Yakov
