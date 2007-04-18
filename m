From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix overwriting of the files to apply the patch to in git-apply
Date: Wed, 18 Apr 2007 18:33:21 +0200
Message-ID: <81b0412b0704180933t7f161bcah57bce6dbea43a710@mail.gmail.com>
References: <81b0412b0704180929h7960bedeje87050fa5ca543b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 18:33:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeD5y-0002iV-8n
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 18:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992824AbXDRQdX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 12:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992825AbXDRQdX
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 12:33:23 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:33722 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992826AbXDRQdW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 12:33:22 -0400
Received: by an-out-0708.google.com with SMTP id b33so260853ana
        for <git@vger.kernel.org>; Wed, 18 Apr 2007 09:33:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kEBRnZsNpGonKWiht2c6N9LMTMLD1E14oE7UtyuNfrZ1boM6831AJhQn2JPqWNWVhhIogmFnOQ6ojWZMK00FJHkPz5FUWI7lCuonZ0YdSJyToJNDJei4RDRUv2CUamVF55KIYAYl4EAUkbtwSh6NYvxmCiDUUqLSwhd/Q81lqi8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YyIGiQbO8y18wKuzZ+eyOAk5UWPmm+zyLqs/ugpmEJ611T6pnsxNGvXCo1yIbEoVXIQdc4kI7E+/HiOTm+BgCU1CeCyDFmTkRdltegU5XS3qsTm3T45n2tFsbYLSwF/Wyv56xt113DfmBaxr+J3zv+XE5DlBTxINCyEipizE3j0=
Received: by 10.100.125.5 with SMTP id x5mr513207anc.1176914001461;
        Wed, 18 Apr 2007 09:33:21 -0700 (PDT)
Received: by 10.100.225.3 with HTTP; Wed, 18 Apr 2007 09:33:21 -0700 (PDT)
In-Reply-To: <81b0412b0704180929h7960bedeje87050fa5ca543b0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44913>

On 4/18/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> The decision to check for directory first looks suboptimal.
> Why not try to _rename_ first and if that fails check if we've got a directory?
> An existing file seems to be more of a common case.

Simplier to code and read, for one.
