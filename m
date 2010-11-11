From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: selectable configurations that change with
 each request
Date: Thu, 11 Nov 2010 15:42:50 -0600
Message-ID: <20101111214250.GA27048@burratino>
References: <20101111213456.21127.36449.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Julio Lajara <julio.lajara@alum.rpi.edu>,
	Sitaram Chamarty <sitaram@atc.tcs.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 22:43:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGevZ-0000uj-7A
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 22:43:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757234Ab0KKVnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 16:43:21 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58455 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757021Ab0KKVnT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 16:43:19 -0500
Received: by vws13 with SMTP id 13so681000vws.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 13:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9S1ikCMZwXo6JEp4yVtmNC1ZRKXTt+RReBvTZaffXOM=;
        b=TIhBFKHTOODWHgDvxtfcLCP+mAFZjJprlb6+bNPgz83K8xVtlMsRB9xUyMdIPpzcBc
         m6rwaYSHVLqoDKq0vYDpbdkUgXBNJEUD/4hXC59uznGSVyVuC0QIiGGz64FsWzQyl+aV
         oARaAy9UI1FALDuFUPrfsVIxWdRYweV3sNgbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sPWXmukKxhuMnrFx6VdqXBrUQc6571L8G1DP7lJaIAsQ1/NZQLAFuKYlqd+f6u/2Ji
         xwgluHIDv/jUUir4tQXEVl/4S+X11+OoofMh7NyGip5N0FmbCI9cmIosMBKbO4SmCkEk
         Iqg5JTEfl+Gysn9Mskz62Mo3D79c4RWWXpH8g=
Received: by 10.220.182.75 with SMTP id cb11mr296312vcb.53.1289511798466;
        Thu, 11 Nov 2010 13:43:18 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id j13sm729341vcr.41.2010.11.11.13.43.16
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 13:43:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101111213456.21127.36449.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161302>

Jakub Narebski wrote:

> This is done by introducing $per_request_config variable: if set to code
> reference, this code would be run once per request, while config file would
> be parsed only once.  For example gitolite's contrib/gitweb/gitweb.conf
> fragment mentioned in 7f425db could be rewritten as
> 
>   our $per_request_config = sub {
>   	$ENV{GL_USER} = ($cgi && $cgi->remote_user) || "gitweb";
>   };
> 
> to make use of this feature.
> 
> If $per_request_config is not a code reference, it is taken to be boolean
> variable, to choose between running config file for each request
> (flexibility), and running config file only once (performance in
> persistent environments).
> 
> The default value for $per_request_config is 1 (true)

Flexible, fast, backward-compatible.  Nice.
