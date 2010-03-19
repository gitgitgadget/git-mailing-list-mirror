From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] Prompt for a username when an HTTP request 401s
Date: Fri, 19 Mar 2010 17:13:37 +0800
Message-ID: <be6fef0d1003190213m48b6c91dx5cbd489cf798dacc@mail.gmail.com>
References: <d411cc4a1003182041p67a93bf6i1528a8eaaab5c805@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Stenberg <daniel@haxx.se>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 10:13:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsYH2-0002f4-Qw
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 10:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421Ab0CSJNj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 05:13:39 -0400
Received: from mail-iw0-f196.google.com ([209.85.223.196]:46076 "EHLO
	mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924Ab0CSJNh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 05:13:37 -0400
Received: by iwn34 with SMTP id 34so2543088iwn.15
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 02:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Zh+AKxbNeq8sOFrncH1WGROKndc6/eD/GhWcb7eD2bI=;
        b=sPPYTFy+UEQ1JP8Pgytf6dcU9A3F4U09hOZ7fxxyJJDbSA6sHNzzbK0a6YzX7pir6t
         VpYM1bU/gcu41yLeDRrAqRR5KDGKH2bbCxDiTYEnATspXjcjkse5xM7rccJeZeX42qxn
         ZVBo7Rq/lahDW1SLXF55yJSjajJWlpd6kkM5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=d3mdl9pJIGCFsZX5jbLETy/VxOjLfbegAggGCOyHlLgnjxyTG/ar5F20t/8YDLCT5K
         dpllYHMPULUYEVOnxZo+IqN4m+2Ju3tuDA/e9Djr/FrQLYuOCHg9zkfJJQNJipJ+389b
         I9gDor8+bd7QmgRKSwgjBkwo3V3SllzqzAZ3M=
Received: by 10.231.167.135 with SMTP id q7mr376940iby.84.1268990017153; Fri, 
	19 Mar 2010 02:13:37 -0700 (PDT)
In-Reply-To: <d411cc4a1003182041p67a93bf6i1528a8eaaab5c805@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142569>

Hi,

On Fri, Mar 19, 2010 at 11:41 AM, Scott Chacon <schacon@gmail.com> wrot=
e:
> When an HTTP request returns a 401, Git will currently fail with a
> confusing message saying that it got a 401. =A0This changes
> http_request to prompt for the username and password, then return
> HTTP_REAUTH so http_get_strbuf can try again. =A0If it gets a 401 eve=
n
> when a user/pass is supplied, http_request will now return HTTP_NOAUT=
H
> which remote_curl can then use to display a more intelligent error
> message that is less confusing.

(added Daniel to the Cc list)

how are you getting 401s? Recently, git set the CURL_AUTH_ANY option,
so if the correct credentials are passed, curl should have "hid" the
401 from us.

--=20
Cheers,
Ray Chuan
