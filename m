From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v4] for-each-ref: `:short` format for `refname`
Date: Tue, 9 Sep 2008 08:52:00 +0200
Message-ID: <36ca99e90809082352q3c87447eme73379673fe652f4@mail.gmail.com>
References: <7vtzcxaxgr.fsf@gitster.siamese.dyndns.org>
	 <1220649383-17916-1-git-send-email-bert.wesarg@googlemail.com>
	 <7vfxoadz5c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, szeder@ira.uka.de,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 08:53:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcx6P-0005Pk-IR
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 08:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756143AbYIIGwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 02:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756294AbYIIGwE
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 02:52:04 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:15194 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756277AbYIIGwC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 02:52:02 -0400
Received: by wx-out-0506.google.com with SMTP id h27so440037wxd.4
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 23:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=AWSV9XZropbvGg7hb1t0o0TGp444QgFx4PJHc6fy778=;
        b=LuHCBY10gUPWdn/cEf9opvyj6V8VksKGV0Zbb4yuvhia8PW2vI1405ZqJUDF4r7Qwq
         uh9CDUrVwt2ELSPQYq8SXlxcnwMzDhjvK3O9h5ec3kosGuZc3SojuZ/r9AE+JjONr9oe
         Ce1ReWqPQt2Zc5dcQ75Orh140BvLElPKPSaWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ejYYCRWYmGvTbVoTrGAm636Tkrl/hxZx5wApsDrKSM5kHQ5RO7vTym1z3Hp0lN5MGi
         cX9O/BsjQ9Ov563OSdGuIkhddXVEAp3vD3p1ysZyJ0puDn7CRSJ6no+96knZcQVCipJS
         iyq2SG4iCUJRVghZ9EI7pHhauFykagDPM9U/Q=
Received: by 10.70.49.9 with SMTP id w9mr20278946wxw.55.1220943120801;
        Mon, 08 Sep 2008 23:52:00 -0700 (PDT)
Received: by 10.70.49.12 with HTTP; Mon, 8 Sep 2008 23:52:00 -0700 (PDT)
In-Reply-To: <7vfxoadz5c.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95341>

On Tue, Sep 9, 2008 at 00:57, Junio C Hamano <gitster@pobox.com> wrote:
> Any followup on this topic since:
>
>  http://thread.gmane.org/gmane.comp.version-control.git/94478/focus=95041
>
>
I plan on looking at the refs/remote test today.

Any opinions, whether we want the 'strict' mode? i.e.:

for refs/heads/xyzzy and refs/tags/xyzzy:

loose mode (current implementation):

  refs/heads/xyzzy => heads/xyzzy
  refs/tags/xyzzy  => xyzzy

there would be a ambiguous warning (if enabled) if you use xyzzy as a
tag, but it resolves correctly to the tag.

strict mode:

  refs/heads/xyzzy => heads/xyzzy
  refs/tags/xyzzy  => tags/xyzzy

will always produce a non-ambiguous short forms.

Bert
