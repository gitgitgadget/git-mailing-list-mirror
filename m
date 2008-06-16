From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: git-rerere observations and feature suggestions
Date: Mon, 16 Jun 2008 18:18:40 +0200
Message-ID: <bd6139dc0806160918w1eea96f3r6f676d7cf186652d@mail.gmail.com>
References: <20080616110113.GA22945@elte.hu>
	 <20080616110918.GA30856@glandium.org>
	 <20080616154851.GA6938@artemis.madism.org>
	 <20080616155747.GB6938@artemis.madism.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Pierre Habouzit" <madcoder@debian.org>,
	"Mike Hommey" <mh@glandium.org>, "Ingo Molnar" <mingo@elte.hu>,
	git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 18:20:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8HQt-0002NW-3j
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 18:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755539AbYFPQSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 12:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754137AbYFPQSn
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 12:18:43 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:33830 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755352AbYFPQSk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 12:18:40 -0400
Received: by wf-out-1314.google.com with SMTP id 27so5284347wfd.4
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 09:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Vqxef3rktyWOlfi5YA2KLq+UpSDYVob42tafrnRksjc=;
        b=elkA3kXTEo9yEw1ORiZ6lMn5nVDnNaP2oXOBmzszMe17Cke5dNoMXOB41vhcPWstZ7
         aROBP2CSEwkNT1VnOHAFv2tfjF9o7O4xALsssGILl9lAyPjRUhuH409v3xtq4vpYwbuR
         UtOR5n5SDwbb15c4XQ+Oz7W318ch9fKDPOhVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=lsRfGVnU/ReDS0cIorpCg2nsQD7a8sQ/Blwzby72N6szbLysXgPvxDqQojdRldO3/S
         kJ9DvYRyko7ODPVLo7m+U3VNwFb2fy2sv9kFX5raIv55gJu5HOZkFbaaZuHYWxAT2Bcn
         //HC8eBLecQU0QmNczS5GBR82wnElcstkZNzc=
Received: by 10.142.172.12 with SMTP id u12mr2429025wfe.116.1213633120225;
        Mon, 16 Jun 2008 09:18:40 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Mon, 16 Jun 2008 09:18:40 -0700 (PDT)
In-Reply-To: <20080616155747.GB6938@artemis.madism.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85204>

On Mon, Jun 16, 2008 at 5:57 PM, Pierre Habouzit <madcoder@debian.org> wrote:
> On Mon, Jun 16, 2008 at 03:48:51PM +0000, Pierre Habouzit wrote:
>>   Actually it would be rather straightforward to put it in the usual git
>> store, and represent the current rr-cache with a flat file that points
>> to the in-git preimage/postimages, and make git-gc aware of those.
>
>  Actually, this is probably a required step in the direction of sharing
> such things btw.

Perhaps an approach similar to the 'notes' implementation can be used,
in which a separate branch is created to contain the notes. This way
the rerere information (being the 'rerere' branch) can be shared
easily (by just pulling the branch), and as said we get free
compression. Another advantage would be that you automagically get the
ability to unlearn a bad rerere by simply (partially) reverting a
commit on the rerere branch!

-- 
Cheers,

Sverre Rabbelier
