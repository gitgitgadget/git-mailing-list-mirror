From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH RFC 2/8] push: add push.default = mirror
Date: Mon, 20 Jul 2009 23:14:32 +0200
Message-ID: <4A64DE38.5090805@gmail.com>
References: <1248112195-3761-1-git-send-email-bonzini@gnu.org> <1248112195-3761-3-git-send-email-bonzini@gnu.org> <7vocrfulpu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 23:14:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MT0C5-0001tR-9H
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 23:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795AbZGTVOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 17:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752738AbZGTVOh
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 17:14:37 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:37580 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbZGTVOh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 17:14:37 -0400
Received: by bwz28 with SMTP id 28so2236398bwz.37
        for <git@vger.kernel.org>; Mon, 20 Jul 2009 14:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=aYEsuF5KAEl7ntDyGIOKDYoJEarbKciYhPlrKbMKsNY=;
        b=pYw/xIewkgPCD8ItFx9rDiv2yRpQGnSfRpKQPDOsHGwq99NwlDMrjJ9V9AaLHoskoT
         VU4W3UvR7jdjKBg6niWrmMVIuilvQCh4FWPlJU8gpwOCeo7lC2QXMOAtOfDW3GU6O4uI
         ODSKVCDOx2yfwyUDcv3wdvwnMdsyYK6S0VAQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=bZyNa053PK1j5nnReuyWqFjjkEUOkeZSAaL4lfV5GphYVEc73jpNfVXOhoyOYRzDRG
         LoelUNRVXLlXjGuiL63pGfPLdpyt4643mzHQfxXIQjBtUdQB5hjYDQroyqd2/kSHaB+G
         +NT7N3nPU58do108InGWI1lUPbnY9iPyC9310=
Received: by 10.204.69.66 with SMTP id y2mr4693036bki.49.1248124474197;
        Mon, 20 Jul 2009 14:14:34 -0700 (PDT)
Received: from yakj.usersys.redhat.com ([85.93.118.17])
        by mx.google.com with ESMTPS id c28sm8596958fka.19.2009.07.20.14.14.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Jul 2009 14:14:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Lightning/1.0pre Thunderbird/3.0b2
In-Reply-To: <7vocrfulpu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123635>


> I think this patch alone (regardless of the rest which I haven't read)
> probably makes sense.
>
> Except that I think the part below contradicts with the --mirror push
> semantics (see remote.c::match_refs()).

        if (!send_mirror && prefixcmp(src->name, "refs/heads/"))
                 continue;

The way I read this, send_mirror will send everything, even if it's
outside refs/heads/*.  So refs/*.

If we agree on the semantics, would you harvest it separately or should 
I resubmit?

Paolo
