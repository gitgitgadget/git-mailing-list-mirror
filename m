From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
Subject: Re: [EGIT] [PATCH v1 1/1] Add an ignored icon
Date: Tue, 24 Feb 2009 00:59:30 +0100
Message-ID: <49A33862.90507@gmail.com>
References: <cover.1235415747.git.ferry.huberts@pelagic.nl> <ec97c536d418f465befba2a7f30f82f0d75004f8.1235415747.git.ferry.huberts@pelagic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Ferry Huberts <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Tue Feb 24 01:01:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbkjS-00028f-2w
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 01:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbZBWX7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 18:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbZBWX7h
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 18:59:37 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:30418 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbZBWX7g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 18:59:36 -0500
Received: by fg-out-1718.google.com with SMTP id 16so30175fgg.17
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 15:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=hcdt1JB8ZPdNza5bcrMOAdlb8Ux6dfGzSp4oJaAJNYE=;
        b=D+iWRYMbQaCAr6n3+/BrT6XpQ1PslpW4vYcpo6VBLgfxR8/67+m9DnspqkEQnYK2CW
         bNs4F8uXRL/orII1CzSboJO0VintaiWeC6KdD59Xxc/pG9xOdOgfN03+N39qDVVslDLr
         Cn6IYqJlzBpDOn7yZqQ57+Jva1J2mCWnce7cw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=iTKAemIEA413JJTr2sGvcOBkwQXktK1ZNEq7pEkUm2T2tdS8rilh6M/uIWJV4GZn5s
         WlZSDoMkn4svofxD5JxU736nwjHnvapj8k1KK+m6aWz9sTfYIZJavWxeYNGke31Eydct
         mojldFnZkVd9LgdfA0RZeyGR9FyFbu4xR5YL4=
Received: by 10.86.65.9 with SMTP id n9mr3295694fga.55.1235433573371;
        Mon, 23 Feb 2009 15:59:33 -0800 (PST)
Received: from ?192.168.1.226? (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id d4sm423112fga.48.2009.02.23.15.59.31
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Feb 2009 15:59:31 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <ec97c536d418f465befba2a7f30f82f0d75004f8.1235415747.git.ferry.huberts@pelagic.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111182>

Ferry Huberts wrote:
> Add an ignored icon to the label decorations page and make
> sure that it is actually decorated: from now on do not ignore
> ignored resources during decoration.

The reason this was not added in the original series was because that's
kind of the point of ignoring a resource -- you don't want any
information about it. Also, none of the other team plugins provide
decorations for ignored resources-

On the other hand, since the decorators are now user configurable,
adding the option to allow users to enable decoration of ignored
resources if they really feel it's useful to them is admittedly in line
with the whole customization idea.

Though I'm not sure if this particular case of customization would cause
more confusion than good, for example in terms of which doors we open by
allowing ignored resources to actually not be ignored (i.e what other
features would you expect to work for ignored resources?).

>  		prefs.setDefault(UIPreferences.DECORATOR_SHOW_UNTRACKED_ICON, true);
> +		prefs.setDefault(UIPreferences.DECORATOR_SHOW_IGNORED_ICON, true);
>  		prefs.setDefault(UIPreferences.DECORATOR_SHOW_STAGED_ICON, true);

If applied, I would argue that the option should be _off_ by default, to
match the behavior of the other team plugins and the normal logical
action of ignoring a resource.

> +	/** Decoration for resource ignored by Git */
> +	public static final ImageDescriptor OVR_IGNORED;
> +

Side-note: the current decoration implementation only uses Eclipse's
concept of an ignored resource -- not .gitignore et al. since we don't
have a standard way of reading those yet.

Tor Arne
