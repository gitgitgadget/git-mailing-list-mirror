From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Basename matching during rename/copy detection
Date: Thu, 21 Jun 2007 13:44:46 +0100
Message-ID: <200706211344.47560.andyparkins@gmail.com>
References: <20070621030622.GD8477@spearce.org> <200706211050.03519.andyparkins@gmail.com> <Pine.LNX.4.64.0706211252190.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 21 14:44:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1M1s-0002wH-ER
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 14:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804AbXFUMov (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 08:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754494AbXFUMov
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 08:44:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:12417 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754742AbXFUMou (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 08:44:50 -0400
Received: by ug-out-1314.google.com with SMTP id j3so564552ugf
        for <git@vger.kernel.org>; Thu, 21 Jun 2007 05:44:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=OfIHY+SQvB23+VgD7oit/TcLljncDXTgnrdioAS8Cfg6I115ImDDMmYHS/JY9wKI/peozdoHXg4OOqv4JKNgzyC9Q+fhHjLH0onxhArFn3Jng1EEZv+BSZk1pciD7fHYG7T5PmiJQQkPABXUhhlm5tQkb86dSv4kzCUDRZBOr9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HQgyPFI4lI+etZxAeok1yFTe2z6p2i5tjqnfZT94MckCDJnju4XlvAPh8ANLnU0MQbsPc18lAcT2jqfd1fBtkYiqzteqVZIf5BTpZ+JZoemiCliwsSt5ies9NOpgzGsyqiKIdQ9FX0jyJiCfsiK380TSompkHFQKZOp2CE0zzNY=
Received: by 10.82.174.20 with SMTP id w20mr3825777bue.1182429885921;
        Thu, 21 Jun 2007 05:44:45 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id c25sm3611492ika.2007.06.21.05.44.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jun 2007 05:44:44 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0706211252190.4059@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50618>

On Thursday 2007 June 21, Johannes Schindelin wrote:

> > would let people keep their copies.  What I was objecting to was the
> > idea that any repository with duplicate files was "stupid".
>
> FWIW I find it stupid, too.

Thanks very much.  Okay, as I've been put in the position of defending this, 
let me give you the use case that has cropped up for me to do this stupid 
thing.

I've got a GUI program with a load of tool buttons.  Each of those buttons 
will, in the final product, be unique images.  When I write the program, I 
want to be able to refer to each of the button images in the correct place.  
e.g.

 setImage( NewButton, "path/to/new-button.png" );
 setImage( OpenButton, "path/to/open-button.png" );
 setImage( SaveButton, "path/to/save-button.png" );

Unfortunately, I can't draw.  So, I open up gimp, draw a big red X and save it 
as new-button.png.  Then I copy that file to open-button.png and 
save-button.png, knowing that at some point in the future, someone will come 
and replace those red-X images with something appropriate.

All those images now go in the repository.  Symbolic links are not an option, 
as it's got to be checkable out on Windows.

Tell me what part of that is stupid?


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
