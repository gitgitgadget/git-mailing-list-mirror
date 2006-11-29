X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2/2] Don't require config file for "stg mail"
Date: Wed, 29 Nov 2006 16:29:32 +0000
Message-ID: <b0943d9e0611290829h291942d7x13247511d16afeee@mail.gmail.com>
References: <20061129035925.6118.78329.stgit@dv.roinet.com>
	 <20061129035930.6118.88435.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 29 Nov 2006 16:30:56 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ho/eL3h86RZREsgAIzTOzK+fmc64d4NyfSJBay66kb6Kux8fU1nr8DqCBQEdwHOgKdZGRhEL2C7f43fBPMPiHMcdtTbXByG6FUWCTQrAN+VF5bHoAPRHJZnWOp89Xt+o5N8MmJ4svUYd5/jcijd5hBkPTrRC7eVDvK/Od5rfSA4=
In-Reply-To: <20061129035930.6118.88435.stgit@dv.roinet.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32650>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpSJV-0007i8-1x for gcvg-git@gmane.org; Wed, 29 Nov
 2006 17:29:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967467AbWK2Q3e convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006 11:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967468AbWK2Q3d
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 11:29:33 -0500
Received: from wx-out-0506.google.com ([66.249.82.227]:47394 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S967467AbWK2Q3d
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006
 11:29:33 -0500
Received: by wx-out-0506.google.com with SMTP id h27so2368423wxd for
 <git@vger.kernel.org>; Wed, 29 Nov 2006 08:29:32 -0800 (PST)
Received: by 10.90.52.2 with SMTP id z2mr2444227agz.1164817772501; Wed, 29
 Nov 2006 08:29:32 -0800 (PST)
Received: by 10.65.133.7 with HTTP; Wed, 29 Nov 2006 08:29:32 -0800 (PST)
To: "Pavel Roskin" <proski@gnu.org>
Sender: git-owner@vger.kernel.org

On 29/11/06, Pavel Roskin <proski@gnu.org> wrote:
> When calculating the string to be used in the From: field, don't requ=
ire
> it to come from the configuration file.  Instead, reuse already known
> authname and authemail values as the default.  They can be taken from
> the GIT_AUTHOR_NAME and GIT_AUTHOR_EMAIL environment variables.

Your patch uses the author of the patch which can be different from
the person sending the e-mail. It could indeed use the author from GIT
variables or configuration (not the patch author) and I already have a
patch from Karl Hasselstr=F6m for this (which I haven't found the time
to check properly).

The reason I added a sender option is because the sender (that gets
added to the e-mail headers) may differ from the author of the patch.
I use one e-mail address as the author but I might be behind an SMTP
server which only allows a different e-mail address and therefore I
set the sender accordingly.

Once I merge Karl's patch, I'll modify StGIT to use the GIT defaults
if there is no sender configured.

--=20
