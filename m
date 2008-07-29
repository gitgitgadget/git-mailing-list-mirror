From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Hackontest ideas?
Date: Tue, 29 Jul 2008 09:12:04 +0700
Message-ID: <fcaeb9bf0807281912t4df1b5cap8f1ff33138fda25e@mail.gmail.com>
References: <20080729000103.GH32184@machine.or.cz>
	 <7vk5f5o6em.fsf@gitster.siamese.dyndns.org>
	 <20080729011404.GI32184@machine.or.cz>
	 <fcaeb9bf0807281855w3b06f624q18f5ac76a3bb405c@mail.gmail.com>
	 <20080729020212.GI10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jul 29 04:13:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNei7-0007GI-5n
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 04:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020AbYG2CMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 22:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752326AbYG2CMI
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 22:12:08 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:22351 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbYG2CMG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 22:12:06 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2225469fgg.17
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 19:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Or9J/M84a4aUv/wTsr8vt0PtIw57VqOwqiyjrNhL+eE=;
        b=Bh5gmkQSP9P0v2T2GXrMFvxSU2mHZXa89mxhm4/ktynsjDR9yHt78337liII2kAzE1
         Iy8Vwji8gmsxEQ4m3NuzA4ARPRKyIIiShTLq6FS+atNTnSk+g9Dq1lfZ5y/lH5LfipIt
         6oYVIAXAUOsKtlU67wGvm3XCrPZeK8amDYSoA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=dQevTsbhWtWf5txMQcItVbveLuX+wq4CGin7sAk/b2a/ug/jxr6SCKGFxZGVdVoeYb
         8vid0nFIeDRJQTrxZVp27gNBgXSLw/8skIqW3bYeQYHJIgxPyXOQqAJL+e+rxbsGbE6S
         K+ITg1AVNmJDwtgsMvgq1C1nahUpjEeBISiTg=
Received: by 10.86.63.19 with SMTP id l19mr3191191fga.60.1217297524527;
        Mon, 28 Jul 2008 19:12:04 -0700 (PDT)
Received: by 10.86.91.2 with HTTP; Mon, 28 Jul 2008 19:12:04 -0700 (PDT)
In-Reply-To: <20080729020212.GI10151@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90551>

On 7/29/08, Petr Baudis <pasky@suse.cz> wrote:
> On Tue, Jul 29, 2008 at 08:55:32AM +0700, Nguyen Thai Ngoc Duy wrote:
>  > On 7/29/08, Petr Baudis <pasky@suse.cz> wrote:
>  > > On Mon, Jul 28, 2008 at 05:55:45PM -0700, Junio C Hamano wrote:
>  > >  > Petr Baudis <pasky@ucw.cz> writes:
>  > >  >
>  > >  > > (What feature in Git or a Git-related tool would you implement, given 24
>  > >  > > hours staight and unlimited pizza supply?)
>  > >  >
>  > >  > "Use 'assume unchanged' bit to implement narrow checkout".
>  > >
>  > >
>  > > I think Nguyen Thai Ngoc Duy is already working on this? (Though I think
>  > >  he does not use the assume unchanged bit; but this will be likely done
>  > >  before the end of September.)
>  >
>  > You are welcome to do ;) I got to narrow checkout from subtree
>  > checkout where 'assume unchanged' bit was unapplicable so my approach
>  > is a bit different, but probably 'assume unchanged' bit is the right
>  > way to go.
>
>
> But I rather liked the elegancy of just narrowing this down to a
>  particular subtree. Is there really a good reason to generalize this
>  further?

I think because it's doable and people do need to narrow to more than
one subtree sometimes. Also it would solve ".git* in parent
directories" problem that is really hard if you strictly do "narrow
down to a particular subtree".

-- 
Duy
