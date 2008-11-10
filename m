From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Stgit and refresh-temp
Date: Mon, 10 Nov 2008 18:10:34 -0500
Message-ID: <9e4733910811101510p74ea9d5hda7d47dc3bf16b5c@mail.gmail.com>
References: <9e4733910811040537p4e88c09an94370154eca12778@mail.gmail.com>
	 <20081107054419.GA27146@diana.vm.bytemark.co.uk>
	 <9e4733910811101508h3cb30752o77b61926aeefed5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Catalin Marinas" <catalin.marinas@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 00:11:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzfvC-0002pN-IK
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 00:11:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbYKJXKg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2008 18:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752126AbYKJXKg
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 18:10:36 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:51302 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbYKJXKf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2008 18:10:35 -0500
Received: by qw-out-2122.google.com with SMTP id 3so1593262qwe.37
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 15:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ewDmaua5gSTDb/BmN0VJ3+2v7jYrEWZ5LP0k83+c31Y=;
        b=mUeZMaFhjdsB8kJjPe6Y9EatOeKf8MhBRL584E9OZUr8abg7nPcko99OXgkn3XdxEj
         fLZiHwq5ui5T2n5+IHRabocsNDMkr/SOnEyx43uVbVca82vx99NenUFYhwHUsOrQ76Vz
         jrltncpZKECwCwSBLLTOJ1cHVeZs+RtMg66SI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=mswVk6vCEmGQhsoYq0hSDNPpmEMy4NdkbAh4xk1jx9DaMNpMEFRoWXVQhcfhqOPTPL
         bsgifc1GPxdBj0Mvv+6/eUCt/+QDqVV06qXAHxyvZz5wPqHjIUcVAnqdEDI+TwIjPrwT
         i95Ptldbw7In3CZ2tc6DXtJh5zLYtLcFZev+A=
Received: by 10.214.114.10 with SMTP id m10mr7450736qac.306.1226358634048;
        Mon, 10 Nov 2008 15:10:34 -0800 (PST)
Received: by 10.214.10.19 with HTTP; Mon, 10 Nov 2008 15:10:34 -0800 (PST)
In-Reply-To: <9e4733910811101508h3cb30752o77b61926aeefed5b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100585>

On Mon, Nov 10, 2008 at 6:08 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On Fri, Nov 7, 2008 at 12:44 AM, Karl Hasselstr=F6m <kha@treskal.com>=
 wrote:
>> On 2008-11-04 08:37:24 -0500, Jon Smirl wrote:
>>
>>> I hit a case when refreshing a buried patch that needed a merge
>>> conflict sorted out. I'm unable to recover out of the state.
>>
>> Hmm, so what you're saying is basically that you did something with
>> "stg refresh -p" that caused a merge conflict, and that messed thing=
s
>> up so that you needed to run "stg repair". Is that right?
>
> Missed the reply.
>
> Yes, that is what happed.
>
> I think the problem was this:
>
> File - xxxxxxx
> Patch A adds a line
> File - xxxxxxxa
> Patch B in the middle adds a line
> File - xxxxxxxab
> I edit it and add a line
> File - xxxxxxxabc
> Line c needs to be patch A
> stg refresh -p A
> ..messed up tree
>
>
>
>>
>> Have you been able to reproduce it? (I would like to add the failing
>> case to the test suite.)

Yes, it happens every time the 'stg refresh -p' triggers a merge confli=
ct.
stg repair seem to fix it and then I touch things up manually.

>>
>> --
>> Karl Hasselstr=F6m, kha@treskal.com
>>      www.treskal.com/kalle
>>
>
>
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>



--=20
Jon Smirl
jonsmirl@gmail.com
