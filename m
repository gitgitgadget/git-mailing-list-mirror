From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC v3 6/8] Add case insensitivity support when using git
 ls-files
Date: Mon, 4 Oct 2010 12:08:22 -0500
Message-ID: <20101004170822.GB5450@burratino>
References: <4CA847D5.4000903@workspacewhiz.com>
 <1286099806-25774-7-git-send-email-avarab@gmail.com>
 <201010041802.57398.robin.rosenberg@dewire.com>
 <4CAA0598.9080409@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Brandon Casey <drafnel@gmail.com>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 19:11:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2oZn-0002vS-Eg
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 19:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756041Ab0JDRLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 13:11:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40727 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754265Ab0JDRLm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 13:11:42 -0400
Received: by fxm4 with SMTP id 4so98645fxm.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 10:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=vq+NEXZt6ew6PW5nzuvC+Jd9MIqEdcw2XYh49YJQmFg=;
        b=bazq2uxXI7qDBk29cXQmWYiIdUI6argGOY/8fIS89kCKcPQ1FrgkbQ8yfw1ph/jtcW
         VBEZGH3tHMcQhZww/zrZaonvQp9lfyjnB8o0XohbCc3OFw47Ge1j09kMOp7gwW7Yw/KD
         MprmX1A9vEANczHwp2J/mMNK8wlZSapzloZvM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Wc2i9w0ajEsB2tl4QHcH8ndDuW/nzxlGm8qggCZi+/wHveZmIWuxhRW5qV8CjinH/G
         dKoltthG7AzJVqOpr8WW9q1eOQSR/zvWyLwj3UN1pnJXK+IsAxB3yQz8FU2NP7RfO6oX
         YeP87gLYFnimwuS+K4AHfi4YkgNqyC9/bNKn8=
Received: by 10.223.126.65 with SMTP id b1mr9389619fas.44.1286212300648;
        Mon, 04 Oct 2010 10:11:40 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id r5sm2332226faq.8.2010.10.04.10.11.37
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 10:11:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4CAA0598.9080409@workspacewhiz.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158068>

Joshua Jensen wrote:

> I do not know about other file systems and what Git actually
> handles.  I was under the impression it didn't handle Unicode
> filenames well in general... ?

Except in cases like ignorecase handling, git treats path components
as arbitrary streams of bytes ('\0' and path separators are forbidden,
of course).  It works pretty well if that's what you need.
