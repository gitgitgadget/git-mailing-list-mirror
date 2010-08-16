From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Commit ID of a branch
Date: Mon, 16 Aug 2010 16:43:40 -0700
Message-ID: <4C69CD2C.9000700@gmail.com>
References: <loom.20100816T231539-211@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Guillermo <guillermog@tricuspide.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 01:46:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ol9O8-00059N-O3
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 01:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679Ab0HPXqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Aug 2010 19:46:39 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:42144 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542Ab0HPXqi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 19:46:38 -0400
Received: by pxi10 with SMTP id 10so2127188pxi.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 16:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=raUDQY8eJV0LwoGuoTkc/cRryPGAEUxDT7SPMlV+moI=;
        b=mgmy1vGigeiIn/1TzSzSEBr3KfUlUNJZkFXNJUVkZeil/MAqRjdN/9DE4vBj2XjJrZ
         Y1Pr3VSPZps4sBfUo8zNtuji2DwrSwixOaQKVMAX4TkNkYm13nBHeA6bAbm+IErSD52s
         FewT5jCBQt7W3b9RmSrqb16HHTmanaM6uwVhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Torf3WLlZXq604M8/zC8nkHUO1Hbif9buZ40zaHTP+a17/Eui5mvsD6bjOXPS78vzk
         MQIUm/6zXVF2lBNuk1SEHTm2awzzk750R4NVIsrj/FOjJXHvSEfWSMSSGjijkCFePn1+
         P3mOGWvgW0sIkCsw2KiChMQCIL56LwXEQQpVY=
Received: by 10.114.39.16 with SMTP id m16mr6971125wam.119.1282002397402;
        Mon, 16 Aug 2010 16:46:37 -0700 (PDT)
Received: from laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id 33sm13103308wad.6.2010.08.16.16.46.00
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Aug 2010 16:46:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.11) Gecko/20100714 SUSE/3.0.6 Thunderbird/3.0.6
In-Reply-To: <loom.20100816T231539-211@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153681>

On 16/08/10 14:19, Guillermo wrote:
> Hello,
> 
> I want to write a script what checks in all my projects which is the submodule
> commit that is registered in every git repo.
> 
> Lets say we have the following structure:
> 
> project1
> - submodule1
> project2
> - submodule1
> 
> I want to find out what file within the .git dir of every project contains the
> proper submodule Commit ID that should be checkout with git submodule update.
> 
> Regards,
> Guillermo

If I understand your question correctly, what you want is

  git ls-tree HEAD submodule1

Which will give you the sha1 of the commit in the submodule your project
should be pointing to. We use this in various scripts at work.

It is also possible to get this information (and more) from a slightly
friendlier submodule command if you want it for non-script usage.

  git submodule status
