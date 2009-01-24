From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: read-only working copies using links
Date: Sat, 24 Jan 2009 12:02:36 +0100
Message-ID: <bd6139dc0901240302q6b3c9a13p56fe39a976882133@mail.gmail.com>
References: <3EE64C92-CB4C-47BD-9C48-E369AED4B82F@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chad Dombrova <chadrik@gmail.com>,
	"Tim 'Mithro' Ansell" <tansell@google.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 12:06:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQgK9-00086u-HV
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 12:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbZAXLCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 06:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbZAXLCi
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 06:02:38 -0500
Received: from mail-gx0-f21.google.com ([209.85.217.21]:45473 "EHLO
	mail-gx0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbZAXLCh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 06:02:37 -0500
Received: by gxk14 with SMTP id 14so4644558gxk.13
        for <git@vger.kernel.org>; Sat, 24 Jan 2009 03:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=TpaLA8dKC6CJ3ZV/Mn62dizvfNoLo8Qkj3u3HuIchaE=;
        b=U8ErIihbWNEVcQ8gk9ccMgZdQ7Mjgf3kBpYmWJZiOFjYAnXa6szwgBGHQiMEa/ZFfb
         CpnNcpuB/ogdEz9eKCOWzRM71XwbYS/rUczEH4rfiexpxvoYDiU5viGyXwAcbw1lYk+k
         z6R1inNSjjHDvJoZoWXsNKKmAAQYjysKrgBo0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=h44Ym43n3K6uptqbgWG1GurpxcfAV3I7TErHTHOrdtIUmGM+ywxCi4QMEeDG6jmL4b
         pLgkzUqxexfyxyOAx0lCMy61Na0HA2iuy4wF1AxQfAfpaxFV/ExN2pliMDRzyijfMYzi
         IOaErHXtvULaTZxMORVRBcEWg+tmc8iBxCFV0=
Received: by 10.150.138.1 with SMTP id l1mr390575ybd.213.1232794956130; Sat, 
	24 Jan 2009 03:02:36 -0800 (PST)
In-Reply-To: <3EE64C92-CB4C-47BD-9C48-E369AED4B82F@gmail.com>
X-Google-Sender-Auth: 349ee066ecc79143
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106962>

Heya,

On Sat, Jan 24, 2009 at 10:17, Chad Dombrova <chadrik@gmail.com> wrote:
> the crux of the issue is that the blob objects would have to be stored as
> exact copies of the original files.  it would seem there are two things that
> currently prevent this from happening.  1) blobs are stored with compression
> and 2) they include a small header.  compression can be disabled by setting
> core.loosecompression to 0, so that seems like less of an issue.  as for the
> header, wouldn't it be possible to store it separately?  in other words,
> store two files per blob directory, a small stub file with the header info
> and the unaltered file data.

I think Tim Ansell (cced) was talking about this at the gittogether
(storing the metadata seperately), as it would benefit sparse/narrow
checkout, another advantage supporting his case?

-- 
Cheers,

Sverre Rabbelier
