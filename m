From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [Monotone-devel] Re: [RFC] mtn to git conversion script
Date: Thu, 4 Sep 2008 16:29:31 +0300
Message-ID: <94a0d4530809040629y2f2d9c74v311b83afebba0051@mail.gmail.com>
References: <94a0d4530808240218j4bedbe3di99303da9addc93a4@mail.gmail.com>
	 <94a0d4530808280203o6d97f69we4768115e12800c2@mail.gmail.com>
	 <94a0d4530809040243k49635fd3kfef1ee22a6865e98@mail.gmail.com>
	 <200809041250.17715.thomas.moschny@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: monotone-devel@nongnu.org, "Anand Kumria" <wildfire@progsoc.org>,
	git@vger.kernel.org
To: "Thomas Moschny" <thomas.moschny@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 04 15:31:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbEv6-0003aq-IE
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 15:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbYIDN3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 09:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbYIDN3e
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 09:29:34 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:53123 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbYIDN3d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 09:29:33 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3295844rvb.1
        for <git@vger.kernel.org>; Thu, 04 Sep 2008 06:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=CqDMr9yNfVbAxbmXZsqLnZCt6tJasPNtlUO7As6C0w0=;
        b=FbCLPF+Pn0eH0/e+53x9tSLG2jXoReRBvUDc39a74HN77RnMMU+PnTk1IUbm0EEFra
         Qi8Xbm6Ikc6Y8WNV6FVBji701Fp5G3rtMmg31yiDVB7ShTyvPsbf8KFT/Iw6K9KMAdXX
         SqBieK7FprBKfZxw3Kly5IYxDho7qg1B5A6vc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=WgW0kaS/dyWE44CFPwo8yScXYFl5Dh03/BCpHhXnqYF9I2vMpiW06arwXXwVgo4lC4
         CLGtrJeMD/HEmMWjO+wWGfwnYso/XfsfhxY1kSdcOoflahxlOsIcPyPyI9tXX36kzb22
         8pG7OlwKRV7kP8V9bwyLxP9EotZbfntRXVwyQ=
Received: by 10.140.135.19 with SMTP id i19mr5687371rvd.70.1220534971977;
        Thu, 04 Sep 2008 06:29:31 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Thu, 4 Sep 2008 06:29:31 -0700 (PDT)
In-Reply-To: <200809041250.17715.thomas.moschny@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94932>

On Thu, Sep 4, 2008 at 1:50 PM, Thomas Moschny <thomas.moschny@gmx.de> wrote:
> On Thu, Sep 4, 2008, Felipe Contreras wrote:
>> Ok, now the basics seem to be working. So I'm uploading some code if
>> anyone wants to take a look.
>>
>> The C code is generating a topologically sorted list of revisions, and
>> storing the relevant information (certs and parents) separately. This
>> code is very fast. It's using GLib and sqlite3, so probably the GLib
>> stuff should be converted to use libgit.
>> http://gist.github.com/8742
>
> You shouldn't access Monotone's sqlite database directly, for various reasons.
> Use the Automation Interface instead, see
> http://www.monotone.ca/docs/Automation.html#Automation. Using 'mtn automate
> stdio', you can feed an arbitrary amount of commands to one single running mtn
> process.

I use mtn stdio when needed, that is, when doing it manually would be
too complicated (get_file). Doing it directly with sqlite3 is *very*
fast, I don't see any reason to not to do it.

Feel free to modify the code for stdio.

-- 
Felipe Contreras
