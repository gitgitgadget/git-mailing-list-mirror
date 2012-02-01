From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Project structure of .NET-Projects using git submodule or something
 different
Date: Wed, 01 Feb 2012 21:29:50 +0100
Message-ID: <4F29A0BE.8000803@web.de>
References: <002401cce069$75ecc1a0$61c644e0$@heigl-online.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Harald Heigl <Harald@heigl-online.at>
X-From: git-owner@vger.kernel.org Wed Feb 01 21:29:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsgoX-0004gq-Kw
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 21:29:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754944Ab2BAU3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 15:29:53 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:43481 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697Ab2BAU3w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 15:29:52 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate03.web.de (Postfix) with ESMTP id 5F3D41B0940D9
	for <git@vger.kernel.org>; Wed,  1 Feb 2012 21:29:51 +0100 (CET)
Received: from [192.168.178.20] ([91.3.200.120]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0LjJaZ-1SQwMa04Z5-00dE9i; Wed, 01 Feb 2012 21:29:51
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <002401cce069$75ecc1a0$61c644e0$@heigl-online.at>
X-Provags-ID: V02:K0:m2RYuwgibWLMaf3yaGZuBVOEfCQDYLhAX0pO6gKLFo8
 1Q89/N7Jo6TfZGYM6Wh7mmw7XdXIPoagZ7VqlNhqI81Sxop6yG
 hS2MKDDlB6TMofyCDHGQCSeGQSIqtnGQKCquKJm+rbLdEEyWXR
 jqYCg8lf6hfwSTvEOIKndWRXrZUf7zL9W6AV1N3jMZl6mKncuS
 getuuujfjQAyLci2qGb/g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189533>

Am 31.01.2012 23:41, schrieb Harald Heigl:
> Let's assume following Project structure (Dependencies and Subdependencies
> are submodules and submodules of the submodules)
> Project
> 	Dependency 1
> 		Dependency 2
> 		Dependency 3
> 	Dependency 4
> 	Dependency 2
> 
> 
> The problem is if I want to build them I need to build 2+3, then 1, 4 and 2
> again and then the project. As you may see project 2 is a submodule of
> dependency 1 and also of project. I don't feel comfortable with this setup.
> What do you think?

Hmm, we try to avoid that kind of setup as having checked out different
versions of the "Dependency 2" submodule could have rather surprising
effects. We get along really well with "Dependency 2" only being present
in the superproject and having "Dependency 1" reference that instead of
having its own copy (So we have submodules which are depending on having
other submodules right next to them). Then the superproject is responsible
for tying it all together.
