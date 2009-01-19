From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2] http-push: remove MOVE step after PUT when sending objects to server
Date: Mon, 19 Jan 2009 01:12:44 +0100
Message-ID: <bd6139dc0901181612p5181c36eub337a339cd777da0@mail.gmail.com>
References: <be6fef0d0901171224y35c3d95cn2d38639ac03c3b8f@mail.gmail.com>
	 <7viqod5thi.fsf@gitster.siamese.dyndns.org>
	 <be6fef0d0901171919ub28dda7ref6443abec3627aa@mail.gmail.com>
	 <alpine.DEB.1.00.0901181425420.3586@pacific.mpi-cbg.de>
	 <7vocy4wfb2.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0901182214180.3586@pacific.mpi-cbg.de>
	 <7vvdscthmq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Ray Chuan" <rctay89@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 01:14:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOhmN-0006kN-1K
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 01:14:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191AbZASAMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 19:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754042AbZASAMr
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 19:12:47 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:37308 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528AbZASAMq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 19:12:46 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1137415ywe.1
        for <git@vger.kernel.org>; Sun, 18 Jan 2009 16:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=joX5V65tZXCeye9Lsfc5oMUkjOMS78fOEAf41q5z4T0=;
        b=Snifw25wG83K2mduKdg/cf5FrTNyu596YOATauniyWOmmsAfO2JqPeuvftJXehkfAS
         CnnxtdmhXI3SI0zq0JuHRIPwU8zAfbQ1IC3yXDkYJVKtlx/h0HetgX5KuyHhPVc4CRz9
         bAq+lQl7N30ErfAjr3MkHQqCjObk0CJsX5pZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=Za7o3ExLmoVU0yiU0X9OCJRn3sSoos1LB8XTnzSe4DtkmZBtLyJXucIkc+KX2Qzg6l
         CBbGfk32E1aWS9b0hzyCEOSNv+6aBdYM9xFmEMh+fyX+fywRWfYFtfDb2SwF3TEcoOJ2
         7v7BQX3oBIkguP5vhjCBvGnjpnqZwaf7kbWPQ=
Received: by 10.151.44.15 with SMTP id w15mr5313766ybj.51.1232323964988;
        Sun, 18 Jan 2009 16:12:44 -0800 (PST)
Received: by 10.150.121.4 with HTTP; Sun, 18 Jan 2009 16:12:44 -0800 (PST)
In-Reply-To: <7vvdscthmq.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: a440f10b4255160a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106293>

On Sun, Jan 18, 2009 at 22:43, Junio C Hamano <gitster@pobox.com> wrote:
> If "slow" is a problem, why are you using http to begin with ;-)?

Because http might be the only available protocol?

> I'd take slow but reliable any day over fast and mostly works but
> unreliable.

Yes, but if we want, say, git support at code.google.com (which I do,
I totally detest having to use svn because of this), it would be nice
to not dismiss http as "being slow anyway, so who cares about not
making it faster"?

-- 
Cheers,

Sverre Rabbelier
