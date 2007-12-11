From: "Jason Sewall" <jasonsewall@gmail.com>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 14:27:37 -0500
Message-ID: <31e9dd080712111127h72ca18a4o574f3e65ff1acb16@mail.gmail.com>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
	 <e5bfff550712111032p60fedbedu304cab834ce86eb9@mail.gmail.com>
	 <4aca3dc20712111103s1af3b045h484ea749378c6282@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Marco Costalba" <mcostalba@gmail.com>, git@vger.kernel.org
To: "Daniel Berlin" <dberlin@dberlin.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 20:28:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Am0-0005CI-DG
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 20:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbXLKT1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 14:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753805AbXLKT1j
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 14:27:39 -0500
Received: from an-out-0708.google.com ([209.85.132.251]:34337 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567AbXLKT1i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 14:27:38 -0500
Received: by an-out-0708.google.com with SMTP id d31so508236and
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 11:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Jjqg0sPSRpynUr8jRV+qUuWUnGYQaX6fbXThDVYr3Hk=;
        b=hWHokiu7P7zoO81wrJQc1kUEEUpw2pb+JzJSZYGoIgFXjI0LBKuFl9cIywvTBzwvYcwQe2504gWO/GhbqmSP3MMgLQFg1+pxHTKKEIhwaPlgQe/BrdSZ3SjCUjpXLxUGwDPRFaB8fWQVW4mSYGQ4sZlu4sNWeC6k4/cG65oyjSA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=de1GHmXacyFqx2TfcHnjQr6LGcZEJqXRbupDgB5bKWEv58fwd6ugwMxQnW2mJiEn4c2ZsYC56VmMpnH53sHKCJ8ZnVqua20oHYjCl4Lr4w5ASR3tXHtc5m2+ebrz2aoaRrCTvcEw7X261rABfCNLM56Mk0iSrm5LUmf4DeApDWk=
Received: by 10.101.67.11 with SMTP id u11mr17005952ank.1197401257756;
        Tue, 11 Dec 2007 11:27:37 -0800 (PST)
Received: by 10.101.66.17 with HTTP; Tue, 11 Dec 2007 11:27:37 -0800 (PST)
In-Reply-To: <4aca3dc20712111103s1af3b045h484ea749378c6282@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67916>

On Dec 11, 2007 2:03 PM, Daniel Berlin <dberlin@dberlin.org> wrote:
> It is stored in an easier format. However, can you not simply provide
> side-indexes to do the annotation?
>
> I guess that own't work in git because you can change history (in
> other scm's, history is readonly so you could know the results for
> committed revisions will never change).
>

I don't know how other scms work, but history is definitely readonly
in git - whatever sha1 you have that describes a commit was calculated
based on its ancestor commits.

If you have a commit's id, it will *always* refer to the same thing -
a tree state and its complete ancestry.
