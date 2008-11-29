From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2ter 2/2] gitweb: clean up gitweb_check_feature() calls
Date: Sat, 29 Nov 2008 23:16:29 +0100
Message-ID: <cb7bb73a0811291416h4c227411u61bfe7033f0d2bae@mail.gmail.com>
References: <1227904793-1821-3-git-send-email-giuseppe.bilotta@gmail.com>
	 <1227959616-8056-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <7vej0u1d2c.fsf@gitster.siamese.dyndns.org>
	 <7vzljiz1qn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>,
	"Petr Baudis" <pasky@suse.cz>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 29 23:18:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6Y93-0002AJ-Tt
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 23:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbYK2WQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 17:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752715AbYK2WQc
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 17:16:32 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:1853 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbYK2WQb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 17:16:31 -0500
Received: by ey-out-2122.google.com with SMTP id 6so816108eyi.37
        for <git@vger.kernel.org>; Sat, 29 Nov 2008 14:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=PkEwfBLMpCe7M1iWKG8z1lUpxAt5XwuzzqdwApySP4I=;
        b=VGSclABuwtcKWYREdh5wymQgXhDmIUzaUNkGfM8qtXpVakrS2QS6L7euFoIQxCJjDr
         1O2ONrBZo4cDvMkqux6Mz2400ltOHvSIY90+5kgF5Ju/luzH3zRaCGTlgr80klFBEAmP
         1afHNdlJs58674S/EaN+45gjBJgrEyR4T0L08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=sY0UdaRbzjFuNGmHW1nN3ppeKMNIl/wqD4RnZ8zjUVAZAKy8m1ytqarnZEIH1kBtG0
         IazEwUvbz6ELacWGF/gQmnIz0iJz/mSe9Re7GBYMYfjOnpCi96b+EDskV7kmZeRhZdRw
         PuA6b4AYXZBS4aqcWh+F7wwHLC/bngVoJnga8=
Received: by 10.210.10.8 with SMTP id 8mr10641726ebj.172.1227996989858;
        Sat, 29 Nov 2008 14:16:29 -0800 (PST)
Received: by 10.210.79.12 with HTTP; Sat, 29 Nov 2008 14:16:29 -0800 (PST)
In-Reply-To: <7vzljiz1qn.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101929>

On Sat, Nov 29, 2008 at 10:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> ...  The change is not
>> about fixing (your proposed commit log message read "gitweb:fixes to
>> gitweb feature check code") as nothing is broken.  It is purely about
>> futureproofing and I think we should mark it as such.
>
> Actually, there is a handful clueless/careless callers.  Before applying
> any of the check => get patch, let's do this as a fix.

And this is precisely the reason why the first time I sent the patch I
did the restyling in the same go: by not touching the
clueless/careless callers and instead bringing gitweb_check_feature to
act in scalar context, it would automatically fix those broken usages,
and it made sense to convert all array-to-get-a-scalar assignmets as
well.

-- 
Giuseppe "Oblomov" Bilotta
