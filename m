From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH/RFC 1/3] t3030-merge-recursive: Test known breakage with
 empty work tree
Date: Fri, 24 Jan 2014 12:50:50 -0500
Message-ID: <52E2A7FA.10307@kitware.com>
References: <CABPp-BGAsrrjcZxVirzKU_VEyUM1U=4TFj18CieKKE7==c7v2A@mail.gmail.com> <cover.1390574980.git.brad.king@kitware.com> <bee33fbfe83408a69085d58db302b3e72edf16a4.1390574981.git.brad.king@kitware.com> <20140124165112.GK18964@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, newren@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 24 18:56:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6kzH-0005PI-9f
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 18:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbaAXR4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 12:56:10 -0500
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:45550 "HELO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751147AbaAXR4I (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jan 2014 12:56:08 -0500
X-Greylist: delayed 344 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Jan 2014 12:56:08 EST
Received: from mail-ie0-f176.google.com ([209.85.223.176]) (using TLSv1) by na3sys009aob131.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUuKpMq0Nw9f9e6isTM+KBtgszczYjHSV@postini.com; Fri, 24 Jan 2014 09:56:08 PST
Received: by mail-ie0-f176.google.com with SMTP id tp5so3101011ieb.7
        for <git@vger.kernel.org>; Fri, 24 Jan 2014 09:55:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=MUlkDyhe29pEQDkiO5NjBAbBPAS79cQSyGlA7vFwPsM=;
        b=Cd+EV1wCKJST0ssGrLa5PvJnGz48qNnz3IS/wXdEXu9M6z1gCTVQOecitHUuzr7hS5
         BRxHlEWbiAKwIJaHTQzYGOmSrU9DcBYKANRmjBV/HRahkFH4aOKQ6rCDJwZj6DWXflYa
         Lrz9qMWRWQXcT3dt2x2E9SSHFEjNxbd+szrEzNhHNVjg7COJHX5OgHn5WhuVN1fC6e5y
         22lNI6gfFEn4IFtWLpa1LBJ2jOUQRj/tRQWhOST0+vsd59eIgRAIFC5lOf45ivtJWWTx
         wvCkqHczg1EhdkKjWNPpP8+EBUZhok8pnTZX4ip8Zio6vixibKjs964YSwMc8UUCk6QE
         VxWg==
X-Received: by 10.50.239.162 with SMTP id vt2mr5853981igc.48.1390585823076;
        Fri, 24 Jan 2014 09:50:23 -0800 (PST)
X-Gm-Message-State: ALoCoQksCXr268ofve3iOnZkuPf+zm/3A3183YDtMI5cK4GCdmZLXE5CE6xe6bjlC3rQALXRBSXQ5tTkz+01cvhCd4cZRNKlRdzWnvdzr+skRec/t/INGsEBhJr+MrW6rSKzqRMNDKYYAGycqKj6EM0IqHnd5/CsEg==
X-Received: by 10.50.239.162 with SMTP id vt2mr5853975igc.48.1390585822992;
        Fri, 24 Jan 2014 09:50:22 -0800 (PST)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id ml2sm10857227igb.10.2014.01.24.09.50.21
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 24 Jan 2014 09:50:22 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <20140124165112.GK18964@google.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241018>

On 01/24/2014 11:51 AM, Jonathan Nieder wrote:
> a quick summary of the symptoms and when it came up?

You're suggested commit message correctly explains it:

> Do you mean something like the following?
> 
> 	Sometimes when working with a large repository it can be useful to
> 	try out a merge and only check out conflicting files to disk (for
> 	example as a speed optimization on a server).  Until v1.7.7-rc1~28^2~20
> 	(merge-recursive: When we detect we can skip an update, actually
> 	skip it, 2011-08-11), it was possible to do so with the following
> 	idiom:
> 
> 		... summary of commands here ...
> 
> 	Nowadays, that still works and the exit status is the same,
> 	but merge-recursive produces a diagnostic if "our" side renamed
> 	a file:
> 
> 		error: addinfo_cache failed for path 'dst'
> 
> 	Add a test to document this regression.

Yes, thanks.

> Elsewhere in the test, commands in a subshell are indented by another
> tab, so these new tests should probably follow suit.

Great.  I'll fold both of the above into the next revision of the series.

Thanks,
-Brad
