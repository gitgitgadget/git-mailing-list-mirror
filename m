From: "Patrick Doyle" <wpdster@gmail.com>
Subject: Re: Split a subversion repo into several git repos
Date: Thu, 11 Oct 2007 10:02:21 -0400
Message-ID: <e2a1d0aa0710110702o359d6cd9yaa213be6a43924e4@mail.gmail.com>
References: <op.tz09zaizjwclfx@ichi>
	 <27DDC599-C7A0-4660-B5C6-7DFCEB137C14@steelskies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Eivind LM" <eivliste@online.no>, git@vger.kernel.org
To: "Jonathan del Strother" <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 16:04:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifyct-0007bp-CN
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 16:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757717AbXJKOC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 10:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757451AbXJKOC1
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 10:02:27 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:7130 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756226AbXJKOCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 10:02:25 -0400
Received: by nf-out-0910.google.com with SMTP id g13so475805nfb
        for <git@vger.kernel.org>; Thu, 11 Oct 2007 07:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=jeicsC6mecNRAsBq5yKZD7VvRQ/hL2PW7OJDEZZTCfE=;
        b=ZA1lT0afQogQEIpbW914f2KXQXmiOKeUTrVZA4OuL0EbfeLy178EXjpGJ07ovc/OWL30NGWsCohQyxat+KDAezCD4yZnaBu+tJwmQHoflj8gfUo9sPLtp61ktpQUaiodR6Su44VTOMHlftTW3bsbelbolagLfgqr80tRA5nD3uE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OiOejh0zXDX824mI4c+OdjwleMy5/GyWOlBJiXF1lk6hQVMTp/04idsTDdDzYdckSuSCFgjQl7umZagF3eQJEyE/9JbAc9IHuh9b0RlOOHgzXm9fS6c8A5VuC0IyrjXavUSvfqZYg6lO9W7Ih5KlvttGeRiPweadcySs5KF5PUY=
Received: by 10.78.180.18 with SMTP id c18mr1464349huf.1192111341508;
        Thu, 11 Oct 2007 07:02:21 -0700 (PDT)
Received: by 10.78.193.15 with HTTP; Thu, 11 Oct 2007 07:02:21 -0700 (PDT)
In-Reply-To: <27DDC599-C7A0-4660-B5C6-7DFCEB137C14@steelskies.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60598>

On 10/11/07, Jonathan del Strother <maillist@steelskies.com> wrote:
> I have a slightly different layout to you -
>
> projectA/trunk
> projectA/branches
> projectA/tags
> projectB/trunk
> projectB/branches
> projectB/tags
> etc
>
> - but I've been creating separate git repos from that with (for
> example) :
>
> git-svn init -t tags -b branches -T trunk http://svn.host.com/projectA
> git-svn fetch
>
Just be aware that, if you follow this approach, the commit logs
created by git-svn will be rewritten (relative to the original SVN
logs) with the SVN repository revision and ID information.  I believe
you can disable this behavior by passing the --no-metadata option to
"git-svn init", but I haven't tried this yet.

I also believe that this approach will leave your git repository in
such as state as to recognize that there is a remote repository from
which this repository was fetched.  I have no idea what implications
and long term repercussions (if any) this has.  It just dawned on me
as I was rereading the git-svn man page to look for the --no-metdata
option and read that it will "Set the noMetadata option in the
[svn-remote] config".  Most of that is still Greek to me.

--wpd
