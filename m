From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git send-email prompting too much
Date: Sat, 4 Apr 2009 22:49:14 -0400
Message-ID: <76718490904041949w4b66d9ffkbf06299fbff22db9@mail.gmail.com>
References: <449c10960904041002s22124b74k8440af216b1de9ee@mail.gmail.com>
	 <80hc148hso.fsf@tiny.isode.net>
	 <76718490904041913s2c769022t92ca194263e29eb0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Dan McGee <dpmcgee@gmail.com>, git@vger.kernel.org
To: Bruce Stephens <bruce.stephens@isode.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 04:50:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqIRe-000621-AS
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 04:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756715AbZDECtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 22:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756703AbZDECtR
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 22:49:17 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:32259 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756700AbZDECtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 22:49:16 -0400
Received: by yx-out-2324.google.com with SMTP id 31so1615387yxl.1
        for <git@vger.kernel.org>; Sat, 04 Apr 2009 19:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=z4DiNhiff6AtgKe3Sot4humLxN3XdIgYDmr/O00v84g=;
        b=eZTiwMFaru9dxldRIrez0OYzOXIqESm29dXTUfY9h7XmdHK4khKz7YiK0BKEQlwoRY
         i38OcwfSMhNX1BTZy+GpCZOH+CMN9PxPDBNK0vg7jy08GyrlTSunYpzXVYnpJnzlw2H6
         RvpaUKcq3byU5E6+m6deyChMFDcHjv1WhCcRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=O0g/Jy8lmSWW1Ubgs4vTivyIhrKLdgB0W/sw8b2mp0/X6iNHaVGCKYgedlsV0zzdrj
         Jd84mbNqyhxv2wJZY8dPbDiK4rYFxenBqnndNvmaNuWzNUY9ZuqCX+PRIHC2hSVCBz2h
         Wkreiefg6Bwd3VM3Z/NzG4gYM9Zqpjl9DLzrQ=
Received: by 10.151.51.13 with SMTP id d13mr5497314ybk.61.1238899754375; Sat, 
	04 Apr 2009 19:49:14 -0700 (PDT)
In-Reply-To: <76718490904041913s2c769022t92ca194263e29eb0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115621>

On Sat, Apr 4, 2009 at 10:13 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> Wait. Did hitting just enter work in the past? Because I tested this
> before I made this commit and at least on my machine, hitting enter
> just presented the prompt again. So I retained that behavior.

Argh. I should read my own commit message. I claim:

    2) "Who should the emails be sent to?". Previously this prompt passed a
    second argument ("") to $term->readline() which was ignored. I believe
    the intent was to allow the user to just hit return. Now the user
    can do so, or type ctrl-d.

    3) "Message-ID to be used as In-Reply-To for the first email?".
    Previously this prompt passed a second argument (effectively undef) to
    $term->readline() which was ignored. I believe the intent was the same
    as for (2), to allow the user to just hit return. Now the user can do
    so, or type ctrl-d.

Clearly I broke something. Will send a patch shortly. :-(

j.
