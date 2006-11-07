X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Add a MIME-Version header to e-mails
Date: Tue, 7 Nov 2006 19:09:06 +0000
Message-ID: <b0943d9e0611071109w584f4f7fv3ba1b7dbd9413717@mail.gmail.com>
References: <eile19$p7r$1@sea.gmane.org>
	 <20061106074532.10376.60478.stgit@localhost>
	 <b0943d9e0611070153s2a52f65k6ed4643e60a144b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 7 Nov 2006 19:09:20 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ajwskhjHqbHTBzDmdAqVWAw+EYYPrP6KnxMv6LuCDlfebUhtlmVTBbL+zZ/i6n7r5Fh0SKAKbdz3caV27ru1OYZ6nV2wyVVm/bIP37IKCeChpJS9gRMaG8fUUKpR01s/OICG6Wc23ceKXotGt4Nybj/9aWqQJ30FUfVqF7OkoR4=
In-Reply-To: <b0943d9e0611070153s2a52f65k6ed4643e60a144b3@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31089>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhWJv-0000Xj-Uu for gcvg-git@gmane.org; Tue, 07 Nov
 2006 20:09:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751643AbWKGTJJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 14:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWKGTJJ
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 14:09:09 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:28396 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1751471AbWKGTJI
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 14:09:08 -0500
Received: by py-out-1112.google.com with SMTP id a73so1332738pye for
 <git@vger.kernel.org>; Tue, 07 Nov 2006 11:09:07 -0800 (PST)
Received: by 10.35.13.1 with SMTP id q1mr13592096pyi.1162926547127; Tue, 07
 Nov 2006 11:09:07 -0800 (PST)
Received: by 10.35.77.5 with HTTP; Tue, 7 Nov 2006 11:09:06 -0800 (PST)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
Sender: git-owner@vger.kernel.org

On 07/11/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> I'll include these patches (maybe modified) and I'll try to fix
> "import" as well.

I re-implemented parts of the mail and import commands (inspiring from
your patches). They now use the email Python package. The mail command
encodes the body to 7 or 8bit depending on non-ascii characters. The
headers are QP-encoded. The import command can decode messages
properly and can also handle multipart e-mails.

I still have to write a test script but my simple tests showed that it
works. Please let me know if there is anything wrong (especially with
the QP-encoding of the mail headers).

Thanks.

-- 
