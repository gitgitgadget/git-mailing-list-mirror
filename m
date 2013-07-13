From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v3] config: add support for http.<url>.* settings
Date: Sat, 13 Jul 2013 12:46:17 -0700
Message-ID: <47B58075-3FDD-48E5-9047-8650F7FC5E3B@gmail.com>
References: <9e7edfbc83a7284615af4ca0de39c1b@f74d39fa044aa309eaea14b9f57fe79> <7voba8pu6r.fsf@alter.siamese.dyndns.org> <455666C5-7663-4361-BF34-378D3EAE2891@gmail.com> <7vsizjn390.fsf@alter.siamese.dyndns.org> <7v4nbyic57.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>
To: Junio C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>
X-From: git-owner@vger.kernel.org Sat Jul 13 21:46:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uy5ly-0003aH-It
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 21:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103Ab3GMTqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jul 2013 15:46:22 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:43651 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460Ab3GMTqV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jul 2013 15:46:21 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so9981689pad.16
        for <git@vger.kernel.org>; Sat, 13 Jul 2013 12:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mauler;
        bh=h+IabmDDHdUPu9rfqh531grRVVR2f+sTkkCh+8lZ5NM=;
        b=aeRgx+18yx35ioGccinJ+N4z7oKcXW6mQakMQlB9UMzhO5ponIE8n/ICpOlrkgC5UK
         IDCVCiA23XGMUczQURTCouqxG8NDNllL3Obr2ydmcnsRqaKNKFT77DND54qrQZw25Heg
         SuH0gsbQJGALu9sqp3/Z3Dtszp0qyOcLip3hV7JYYhCtN4vB33GhWVjey7VeMwXQJKnf
         a7VzmEejrxjPp4mXFNoRFJzHzINDENV5mAlavDXg6JMF7idIvX2HCCJDD4mPPH8OSLZO
         M5WrKYvIkNM2MxdG+kCuQtQ+hIvEGVOf+VF0Tn3AEYqQK2qHUMKh7KFMwtOR47kcQTDq
         WIQQ==
X-Received: by 10.69.8.65 with SMTP id di1mr2502622pbd.32.1373744780923;
        Sat, 13 Jul 2013 12:46:20 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id om2sm52071288pbb.34.2013.07.13.12.46.18
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 13 Jul 2013 12:46:19 -0700 (PDT)
In-Reply-To: <7v4nbyic57.fsf@alter.siamese.dyndns.org>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230288>

On Jul 12, 2013, at 13:58, Aaron Schrab wrote:
> At 06:07 -0700 12 Jul 2013, "Kyle J. McKay" <mackyle@gmail.com> wrote:
>> I don't think it's necessary to split the URL apart though.   
>> Whatever URL the user gave to git on the command line (at some  
>> point even if it's now stored as a remote setting in config)  
>> complete with URL-
>> encoding, user names, port names, etc. is the same url, possibly  
>> shortened, that needs to be used for the http.<url>.option setting.
>
> This seems to be assuming that the configuration is done after the  
> URL is entered and that URLs are always entered manually.  I don't  
> think either of those assumptions is valid.  A user may want to  
> specify http settings for all repositories on a specified host and  
> so add settings for that host to ~/.gitconfig expecting those  
> settings to be used later.  A URL in a slightly different format may  
> later be copy+pasted without the user realizing that it won't use  
> that config due to one of the versions being in a non-canonical form.

That seems like a very reasonable expectation to me.

>> I think that's simple and very easy to explain and avoids user  
>> confusion and surprise while still allowing a default to be set for  
>> a site but easily overridden for a portion of that site without  
>> needing to worry about the order config files are processed or the  
>> order of the [http "<url>"] sections within them.
>
> I agree that the method is easy to explain, but I think a user may  
> very well be surprised and confused in a scenario like I described  
> above.  And having the order not matter (in some cases) for these  
> configuration items deviates from how other configuration values are  
> handled.


On Jul 13, 2013, at 10:48, Junio C Hamano wrote:
> The only remaining issue is if matching strictly at the textual
> level is too limiting.  I personally have no strong opinion myself
> on it, and if we start with a limited form, we can always loosen it
> later, so...


The full on everything is to split the URL into all its pieces,  
canonizing (according to RFC 1738) the pieces and probably allowing  
omitted parts to act like wildcards.  I'm not opposed to doing this  
work if that's the consensus.

However, there's probably a shortcut to all that work that will  
address Aaron's concern.

I expect it will be easier just to normalize the URL without  
splitting.  That is, lowercase the parts that are case-insensitive  
(scheme and host name) and adjust the URL-escaping to remove URL  
escaping (%xx) from characters that don't need it but add it to any  
for which it is required that are not escaped (according to RFC 1738).

Basically a url_normalize function added to url.{h,c}.  It can take a  
const char * and return a char * that needs to be free'd.  (Perhaps it  
should live in http.c until some other file needs to use it and  
migrate then?)

This should guarantee a match in the scenario Aaron proposes above and  
still has pretty much the same easy explanation to the user.

Shall I go ahead and add that to the next patch version?

Or proceed with what's there right now (there are a few pending  
updates from reviewers) and then, as Junio says above, adjust it later  
if needed?
