X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: Use git-for-each-ref to generate list of heads and/or tags
Date: Fri, 3 Nov 2006 04:26:32 +0100
Message-ID: <200611030426.32734.jnareb@gmail.com>
References: <200610281930.05889.jnareb@gmail.com> <200611022023.12246.jnareb@gmail.com> <7vhcxhl0bh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 03:26:32 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Am00W2JNL8lsVcMiAPpl5JDYdMRNXAlJEBlAbgkEPRyO/djzFvVmZAYDjBxZ4vMnmzI2NAqqGxzdgliKFTYZHQS5JsqGP6hQpbLiQokyjtpn+lMNoFw/m49iTZdKP+vn2OEnEkyAgG3w3QB7p1Y61DlRpAPLxVnKYIAolQR7N9Q=
User-Agent: KMail/1.9.3
In-Reply-To: <7vhcxhl0bh.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30780>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfphE-0005Ky-EQ for gcvg-git@gmane.org; Fri, 03 Nov
 2006 04:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753014AbWKCD0N (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 22:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753016AbWKCD0N
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 22:26:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:56235 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1753013AbWKCD0M
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 22:26:12 -0500
Received: by ug-out-1314.google.com with SMTP id m3so312181ugc for
 <git@vger.kernel.org>; Thu, 02 Nov 2006 19:26:11 -0800 (PST)
Received: by 10.67.27.3 with SMTP id e3mr1982087ugj.1162524371222; Thu, 02
 Nov 2006 19:26:11 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id o24sm317648ugd.2006.11.02.19.26.10; Thu, 02 Nov
 2006 19:26:10 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
 
>> CHANGES IN OUTPUT: Before, if ref in refs/tags was tag pointing to
>> commit we used committer epoch as epoch for ref, and used tagger epoch
>> as epoch only for tag pointing to object of other type. If ref in
>> refs/tags was commit, we used committer epoch as epoch for ref (see
>> parse_ref; we sorted in gitweb by 'epoch' field).
> 
> I think that behaviour was inconsistent and just silly.  Using
> creatordate consistently is better so if the code generates what
> the commit log claims to, I think that is fine (I haven't looked
> at it deeply yet).

Well, I _could_ argue on the former behaviour, namely that we use
committerdate when available (when ref points to commit, or to tag
pointing to commit), and if it is not available we use taggerdate
if possible.

The latter is that we use always "creation" date.

-- 
Jakub Narebski
