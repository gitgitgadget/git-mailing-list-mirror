X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC (take 2)] gitweb: New improved patchset view
Date: Mon, 30 Oct 2006 01:34:53 +0100
Message-ID: <200610300134.53668.jnareb@gmail.com>
References: <200610291122.30852.jnareb@gmail.com> <200610300051.37896.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 30 Oct 2006 00:35:08 +0000 (UTC)
Cc: Junio Hamano <junkio@cox.net>, Luben Tuikov <ltuikov@yahoo.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Llcho3rRkh679F90LcPnrhC4qr265I/CerHah+dVXV3/v/V2j+Ki7uRSMOcLKIEZXb0/uO3VHx7RUcO6G1Th/zgVPX7+kQOjprA5U3HEHngBtZiVu86LDdTCHrsId22biY99pR9a4yOVJ6hqar0yjSKWPF6hkceA5UfeUbObxsg=
User-Agent: KMail/1.9.3
In-Reply-To: <200610300051.37896.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30476>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeL7I-0003RW-05 for gcvg-git@gmane.org; Mon, 30 Oct
 2006 01:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965353AbWJ3Ae7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 19:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965400AbWJ3Ae7
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 19:34:59 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:35972 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S965353AbWJ3Ae6
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 19:34:58 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1030892ugm for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 16:34:57 -0800 (PST)
Received: by 10.66.220.17 with SMTP id s17mr3274415ugg; Sun, 29 Oct 2006
 16:34:56 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id 28sm2253922ugc.2006.10.29.16.34.56; Sun, 29 Oct
 2006 16:34:56 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Few other questions, probably to be adressed in the future patches, and 
not added to this one.

0. git-ls-tree and git-diff-tree without -z does quote not only !isprint 
characters like LF '\n' and non-space whitespace characters like TAB 
'\t' (and of course quoting characters '\' and '"'), but for example 
also UTF-8 characters. See for example git-ls-tree output for 
gitweb/test directory. This screws somewhat idea how we should treat 
filenames which are quoted.

[BTW. How git should deal with being deployed in the environment where 
filesystem pathnames coding might not be UTF-8, and console (terminal) 
coding might be not UTF-8?]


1. Current version doesn't display empty patches (i.e. pure rename and 
mode change combinations) and doesn't provide links to them from 
difftree. This is legacy of old /usr/bin/diff using code, which did not 
generated extended diff header, which is only output for "empty 
patches". Should we change this, or leave as is?

2. Schould we change syntax highlighting of chunk header line, namely 
changing slightly syntax coloring of "in which function are we" part of 
chunk header?

3. Should we make from-range/to-range in chunk header hyperlink to the 
start of given bunch of lines in appropriate file? Or perhaps to the 
middle of the bunch of lines? Or to first changed line (omitting 
context)?

-- 
Jakub Narebski
