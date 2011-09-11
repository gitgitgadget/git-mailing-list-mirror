From: BJ Hargrave <bj@bjhargrave.com>
Subject: Re: [PATCH] Support empty blob in fsck --lost-found
Date: Sun, 11 Sep 2011 12:20:06 -0400
Message-ID: <E6A02216-CA67-4B66-AA8F-6DDE8AF7DF3A@bjhargrave.com>
References: <A3964281-B24B-46C0-AE73-0CCB4C12556F@bjhargrave.com> <CAGdFq_hqfqdFyLY=KdA_QW5kH8Kjhx8Y18mHEga_Pdv8yzB2wg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 11 18:20:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2mlW-0000k4-B0
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 18:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755176Ab1IKQUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 12:20:11 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44906 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754962Ab1IKQUK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2011 12:20:10 -0400
Received: by gxk21 with SMTP id 21so2944613gxk.5
        for <git@vger.kernel.org>; Sun, 11 Sep 2011 09:20:09 -0700 (PDT)
Received: by 10.236.9.106 with SMTP id 70mr9049601yhs.105.1315758009782;
        Sun, 11 Sep 2011 09:20:09 -0700 (PDT)
Received: from macbookpro2.hargrave.local (106.27.205.68.cfl.res.rr.com [68.205.27.106])
        by mx.google.com with ESMTPS id o48sm11861467yhl.4.2011.09.11.09.20.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Sep 2011 09:20:08 -0700 (PDT)
In-Reply-To: <CAGdFq_hqfqdFyLY=KdA_QW5kH8Kjhx8Y18mHEga_Pdv8yzB2wg@mail.gmail.com>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181178>

On Sep 11, 2011, at 12:03 , Sverre Rabbelier wrote:

> Heya,
> 
> On Sun, Sep 11, 2011 at 17:40, BJ Hargrave <bj@bjhargrave.com> wrote:
>> fsck --lost-found died when attempting to write out the empty blob.
>> Avoid calling fwrite when the blob size is zero since the call to
>> fwrite returns 0 objects written which fails the check and caused
>> fsck to die.
> 
> Now we don't die at all if a 0-byte file couldn't be written.
> Shouldn't we check errno or something?
> 

You don't need to write anything to the 0-byte file. Just create it and close it and there are checks already that verify the fopen and fclose do not fail. So I don't think we are missing any error conditions here.

> -- 
> Cheers,
> 
> Sverre Rabbelier

-- 

BJ Hargrave
