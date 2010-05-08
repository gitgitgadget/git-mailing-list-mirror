From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] Add [] as an alias for a reference to the empty
 tree
Date: Sat, 8 May 2010 11:07:31 -0500
Message-ID: <20100508160731.GA4638@progeny.tock>
References: <1273250247-20762-1-git-send-email-pkj@axis.com>
 <20100508045319.GD14998@coredump.intra.peff.net>
 <7vhbmjc6dy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 08 18:06:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAmY6-00035B-RO
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 18:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331Ab0EHQGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 12:06:37 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:59870 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347Ab0EHQGf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 12:06:35 -0400
Received: by qyk13 with SMTP id 13so3426210qyk.1
        for <git@vger.kernel.org>; Sat, 08 May 2010 09:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=A1n7HuqbUpMHHQZZXTEzg6U19AcVn8blf0Nw3U7KLBc=;
        b=Ee4uESIwxr1EPwRWYJwOCFSIl36g2r0W5X+OiLpKjpWcPCnAjsq9B/RAIQKvbRhPoK
         iPe8mlH7r+tLQKKozq4HHCP8wZoY/Kq5/jbX6ViCucsJqaH6/6chQWYCznA+g4IIhQwC
         Ky1J4Ij9Gc4NIpWpH42YDVjSDS5uj0VcaHQJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=E9+kRlpu0t6/fj7La5mW8Bb0avsbRKaKgRF9xVMlqk/0z1o19TOhBhfYW6Hn/+Y/0t
         4x8VEjIBHFszvBeC1QFHUuSMA2cAGGOERxQKxFIJjgfTcMFb5jw/lFeQ8AAsFFaTFffZ
         v3YxIswjdbCOWEyKYzcw60FNS+Jal64L+eNjM=
Received: by 10.224.72.143 with SMTP id m15mr995871qaj.231.1273334794778;
        Sat, 08 May 2010 09:06:34 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id f5sm2057375qcg.14.2010.05.08.09.06.33
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 09:06:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vhbmjc6dy.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146663>

Junio C Hamano wrote:

> The reason I am not interested in the feature
> is because I don't see much value in running "git diff EMPTY <anything>".
> Perhaps "git archive" might be what the user really wants to find.

I suspect the goal was to use a tool such as checkpatch, or
get_maintainer without -f.  An implementation using git archive should
still work (with the help of a tar diff-ing program with the EMPTY
feature ;-)), but as UI that might be less discoverable than building
it into git diff.

Personally, I liked both the

  git diff $(</dev/null git hash-object -t tree --stdin) $rev

and

  git diff --root $rev

suggestions.  That may be from a warped sense of aesthetics.

Cheers,
Jonathan
