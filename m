From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: About detached heads
Date: Fri, 14 Mar 2008 09:51:43 +0000
Message-ID: <57518fd10803140251v425a0fa3ud11687a5043806cc@mail.gmail.com>
References: <93c3eada0803140246k53408c74m21f9dc277857202d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Fri Mar 14 10:52:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja6aR-0007uA-8L
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 10:52:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbYCNJvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 05:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752238AbYCNJvo
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 05:51:44 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:14590 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112AbYCNJvo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 05:51:44 -0400
Received: by rv-out-0910.google.com with SMTP id k20so2340286rvb.1
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 02:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=5iND9KaOaID0K+V9PB/JsGpjNPGEQzVHYJMkkr1GZOk=;
        b=PWI0fleYtxAsFogXOBig80tf7OGG9FqUVzXX86u0WL6G0K4O9CDawUffnrCR5UQbpNk60WqW2U7afaCCrUyhwumk1HvB8KA5FnCgrjo9oLvn8S0IBr1jbkpXaaaFwBYt/uSduqS83Wk6DLPeCO8ziaI1dSzXx0GrIK99yhwZvj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=jTetegsZVmaY9g7qo7GYD3AN9ykZKUMlwZFbk83Dsofs9y3+j6lV16bW8dS/2tThrEqUBdvf6o1NxKEKDlUnY1iGI+hNeSZBFSab9+BWLKJpC3YnhJqvjDY0mavoMtSnpWTab455xzke/qnGA5RlEjhFoIu2HQvRe8UG2QMB70M=
Received: by 10.141.76.21 with SMTP id d21mr6270095rvl.242.1205488303607;
        Fri, 14 Mar 2008 02:51:43 -0700 (PDT)
Received: by 10.141.86.15 with HTTP; Fri, 14 Mar 2008 02:51:43 -0700 (PDT)
In-Reply-To: <93c3eada0803140246k53408c74m21f9dc277857202d@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: a1ef4e13f55e1399
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77197>

On Fri, Mar 14, 2008 at 9:46 AM, Geoff Russell
<geoffrey.russell@gmail.com> wrote:
> This should be simple! I have a series of commits:
>
>            1---2---3---4---5
>
>  I want to go back to 3 but not branch, so I want
>
>            1---2---3---4---5---3
>
>  ?
>
>          git checkout 3...
>
>  gets me the commit on a detached head, but I don't know how to put this back
>  as the HEAD.


Two options.  Either rewrite history, nuking commits 4 & 5 :
  git reset --hard 3

or publicly reverse the changes introduced by 5 & 4 :
  git revert 5
  git revert 4

Jon
