From: "Geoffrey Irving" <irving@naml.us>
Subject: Re: [PATCH / RFC] cherry: cache commit to patch-id pairs to avoid repeating work
Date: Sat, 7 Jun 2008 22:39:41 -0700
Message-ID: <7f9d599f0806072239je3a7ec0q258d7770c15fa962@mail.gmail.com>
References: <7f9d599f0806071636j1df57b6eqb5808f083dafd6a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jeff King" <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 08 07:41:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5DeR-0004fx-8h
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 07:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbYFHFjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 01:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752148AbYFHFjm
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 01:39:42 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:17170 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbYFHFjl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 01:39:41 -0400
Received: by rv-out-0506.google.com with SMTP id l9so2097877rvb.1
        for <git@vger.kernel.org>; Sat, 07 Jun 2008 22:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=UFKeJ83oIBHIuv63DZGgXkEDGsQAdGkl5ugBRCzZ7G8=;
        b=moTpdK+zYdIDFAtE61S7LhkAoN18MVJk7jSDyqORpuNwedzhpheQaVL8hF8XKIKH+8
         2DkvCA1bbrBOPmw4ODxtyBf6g6oy97pP24YoMNPEEYsAg7/Ul+VCp6PY4usVrA07f41+
         vngRqogpTZh24EhzswoaSnX5sRJWqhxnR0/Qs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=GJv+xMYji8xU7odPldrcqBS2EuCnLx8wK7MJYBNsEjiYlOtttL3VT9QOvZzgJ6XbQ9
         nNfAAgOQ8PJR2+255TyzIgF5hyrZ8oXB38Vm2SEuwGf79t71UG9xFD9CiDHrIl7Hb/J6
         BBjdHvInw2r0zLV2RVHQpnGKdeM1MNYZuoyIQ=
Received: by 10.141.23.7 with SMTP id a7mr1203169rvj.58.1212903581125;
        Sat, 07 Jun 2008 22:39:41 -0700 (PDT)
Received: by 10.140.178.16 with HTTP; Sat, 7 Jun 2008 22:39:41 -0700 (PDT)
In-Reply-To: <7f9d599f0806071636j1df57b6eqb5808f083dafd6a2@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 8bbc5e9c609df324
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84254>

On Sat, Jun 7, 2008 at 4:36 PM, Geoffrey Irving <irving@naml.us> wrote:
> Added cached-sha-map.[hc] implementing a persistent hash map from sha1 to sha1.
> The map is read with mmap, and completely rewritten if any entries change.  It
> would be good to add incremental update to handle the usual case where only a
> few entries change.
>
> This structure is used by patch-ids.c to cache the mapping from commit to
> patch-id into $GIT_DIR/patch-id-cache.  In the one case I've tested so far,
> this speeds up the second invocation of git-cherry by two orders of magnitude.
>
> Original code cannibalized from Johannes Schindelin's notes-index structure.
>
> <snip>

Forgot to cc people from previous threads.

Is starting a new thread each time I update a patch the correct way to
do things?

Geoffrey
