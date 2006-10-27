X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Re: gitweb.cgi and git instaweb
Date: Fri, 27 Oct 2006 11:26:05 +0530
Message-ID: <45419F75.6060103@gmail.com>
References: <ehr00n$vbe$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000605020006050000070009"
NNTP-Posting-Date: Fri, 27 Oct 2006 05:56:54 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type;
        b=bMmESRXW82szUAGOSuzHpoOEWmnBmlmgASdqu+ivZG6JaPRNO0mlkAkB6wd28jWAVjTQRHqjo2Va8KXRDbtSvOMHZlGdZl+JKINNo3x8mvYaoPP8cUJ4++XuCYUUHxVNWkH/bWuPxoOYGl/jJCuJdEInuQQOcNs9ryTVYJBAIko=
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
In-Reply-To: <ehr00n$vbe$1@sea.gmane.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30294>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdKho-0000Ep-0C for gcvg-git@gmane.org; Fri, 27 Oct
 2006 07:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1945977AbWJ0F4S (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 01:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945979AbWJ0F4S
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 01:56:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:15822 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1945977AbWJ0F4R
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 01:56:17 -0400
Received: by nf-out-0910.google.com with SMTP id c2so1175585nfe for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 22:56:16 -0700 (PDT)
Received: by 10.78.166.7 with SMTP id o7mr4287417hue; Thu, 26 Oct 2006
 22:56:16 -0700 (PDT)
Received: from ?217.44.219.183? ( [156.153.255.234]) by mx.google.com with
 ESMTP id 27sm114694hua.2006.10.26.22.56.13; Thu, 26 Oct 2006 22:56:16 -0700
 (PDT)
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This is a multi-part message in MIME format.
--------------000605020006050000070009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Aneesh Kumar K.V wrote:
> I am getting errors as below with git instaweb.
> 
> 
> kvaneesh@satan:/home/opensource/vanilla/linux-2.6-git$ git instaweb
> 2006-10-27 00:12:56: (log.c.75) server started
> kvaneesh@satan:/home/opensource/vanilla/linux-2.6-git$ [Fri Oct 27 
> 00:12:57 2006] gitweb.cgi: "our" variable $stylesheet masks earlier 
> declaration in same scope at 
>

The attached patch should fix it.

-aneesh

--------------000605020006050000070009
Content-Type: text/x-patch;
 name="gitweb.perl.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gitweb.perl.diff"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ba7a42a..1962c76 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -55,8 +55,6 @@ our $stylesheet;
 # default is not to define style sheet, but it can be overwritten later
 undef $stylesheet;
 
-# URI of default stylesheet
-our $stylesheet = "++GITWEB_CSS++";
 # URI of GIT logo (72x27 size)
 our $logo = "++GITWEB_LOGO++";
 # URI of GIT favicon, assumed to be image/png type

