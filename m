From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Commiting automatically (2)
Date: Mon, 3 Jan 2011 18:34:08 +0100
Message-ID: <201101031834.09115.jnareb@gmail.com>
References: <loom.20101219T090500-396@post.gmane.org> <201012271304.03915.jnareb@gmail.com> <4D211AA4.4050108@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Maaartin-1 <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Mon Jan 03 18:34:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZoIq-00088o-Ty
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 18:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405Ab1ACRee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jan 2011 12:34:34 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36730 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932303Ab1ACRed (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jan 2011 12:34:33 -0500
Received: by wwa36 with SMTP id 36so14356924wwa.1
        for <git@vger.kernel.org>; Mon, 03 Jan 2011 09:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=OKHNAIT1fewiHRxEbKNWuPl00rYrj1bdAd8i+xkFwvM=;
        b=Pq33esYYAr/iIgGnBWGjG/kbs45Iumr7bLY5ODnkYJ2IJmAl3Y8M9+8JqU/uMi8HyX
         DUtdMm0BCUY+1ahLmuyHb26GR5Xj2G5SZaF0DDk2ldjxv2m4c4FUxhaU6hvSh1IULFMA
         M3qBfNHwQq09QpLy2jCgT3rCjwBkXOv1j2o9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=B7EbVvO6fho2nBqYssnjiiaxiGRBhL5cJ+pzB1k0X4nVHtTQyvhqg3SjjkV8nqQ0eq
         ZdEAUj67LuCUiOxSWrp6lN+hYieeo58PSw6s10c5vJNureouF8n8+ftEfgE0FJ+iTrZn
         CKdomVo/E/odP6f8LrgAiS7GpIa46rABC/yQ4=
Received: by 10.216.171.19 with SMTP id q19mr2882608wel.53.1294076072578;
        Mon, 03 Jan 2011 09:34:32 -0800 (PST)
Received: from [192.168.1.13] (abwu207.neoplus.adsl.tpnet.pl [83.8.244.207])
        by mx.google.com with ESMTPS id m50sm9996633wek.32.2011.01.03.09.34.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Jan 2011 09:34:19 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4D211AA4.4050108@seznam.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164452>

On Mon, 3 Jan 2011, Maaartin-1 wrote:
> On 10-12-27 13:04, Jakub Narebski wrote:
>> On Wed, 22 Dec 2010, Maaartin-1 wrote:

>>> Moreover, git-show-ref --head shows all branches and tags, this can't be
>>> right, can it? According to your above explanation, getting HEAD using a
>>> pattern is impossible, so I'd say that's what is "--head" good for.
>>>
>>> Moreover, "git-show-ref --heads" shows less than "git-show-ref --head",
>>> despite the plural.
>> 
>> "git show-ref --head" is strange in that it doesn't play well
>> with '--heads' and '--tags' and '<pattern>'.
>> 
>> I think it is a bit of misdesign, but I don't know how it should be
>> fixed; current output of "git show-ref --head" has to be kept because
>> of backward compatibility - git-show-ref is plumbing.
> 
> I wonder what
> git show-ref --head
> really does. It seems to output everything, is this the expected (albeit
> strange) behavior? Maybe, I know now, s. below.
> 
> For sure, either the doc is completely wrong or the implementation. I
> hope I understand "Show the HEAD reference" correctly as showing the
> HEAD reference, don't I? So it must show a single reference (singular).
> Instead I get all tags and all heads. Could anybody either fix the doc
> or convince me that the many lines I'm seeing are a single one?

Well, it might be that *both* documentation and implementation are wrong.

> 
> Shouldn't there be an option *really* doing what --head is expected and
> documented to do? I mean something like
> git show-ref --head --yes-I-really-mean-the-head
> with the output consisting of a single line like
> 4ba2b422cf3cc229d894bb31c429c0c588de85c0 HEAD
> Maybe it could be called --head-only.
> 
> It could help a lot to add the word "additionally" to the doc like
> --head
> Additionally show the HEAD reference.

Well, actually it doesn't do that.  If '--head' is *alone* ref selector
(e.g. "git show-ref --head") it shows HEAD reference in addition to all
other refs (e.g. what "git show-ref" would show).  But it doesn't seem
to work in described way when combined with any of ref specifiers; neither
"git show-ref --head --heads" not "git show-ref --head master" work as 
one would expect.

> 
>>>> I tripped over strange git-show-ref <pattern> semantic too.
>>>>
>>>> P.S. there is also git-for-each-ref.
>> 
>> I don't know why there is git-show-ref when we have git-for-each-ref
>> for scripting; I guess they were added nearly at the same time...
> 
> I guess, I can get the single line I wanted using
> git for-each-ref $(git symbolic-ref HEAD)
> right?

Well, both git-show-ref and git-for-each-ref are meant for checking or
viewing multiple refs at once.  If you are working with a single ref,
then git-rev-parse (e.g. "git rev-parse --symboolic HEAD" or 
"git rev-parse --symbolic-full-name HEAD") or git-symbolic-ref would be
a better choice IMHO.

-- 
Jakub Narebski
Poland
