From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jun 2015, #06; Wed, 24)
Date: Thu, 25 Jun 2015 20:14:06 +0200
Organization: gmx
Message-ID: <20853ca02f86d3e524fa961eef1f1d2e@www.dscho.org>
References: <xmqqwpys95bm.fsf@gitster.dls.corp.google.com>
 <CAGZ79kby0RaKiS2e4o7O7OyLGCftMYVJppvATyPxpzJUOe59jw@mail.gmail.com>
 <d825b05938778f4ee911cbb8c3c8573b@www.dscho.org>
 <xmqqtwtw0w20.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 20:14:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8BfF-0002U0-UT
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 20:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbbFYSOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 14:14:14 -0400
Received: from mout.gmx.net ([212.227.17.22]:59709 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993AbbFYSOM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 14:14:12 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MWTSA-1ZbKQH2Dow-00XfUn; Thu, 25 Jun 2015 20:14:07
 +0200
In-Reply-To: <xmqqtwtw0w20.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:BDDodpnBFs7duaP7u8iU93oEj8+inm1gNXdqo8nTC0ewp21I1t0
 vOf+dhkLV73dMx/LJpCiYapLX4Qf2qGRJzX4vt7zvm7Hq6IvUmsbCo1zh20deAtPnC7NUvj
 l85EP5/y+lepHSWWiKJtJOnKVp8XyhklXHa/g64ET7vUmjPEHb409BfOY+mFM5ER/uqRdd9
 uu3YAwi06WCfjOLBPgMDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Be0x74ityA0=:wl03Nm6oUUswLaDevvVyoD
 5pREpIzMMpfISpH8sqeaWlBYEjR36/PWa8ghDX24VrkEs4qvrYLhtzp6qFDWRzS8H70GyQOB/
 LJj2QO9CW2eUcQOQVn/UPkaDLR6fQP33OY+Oyb6zNsmTOV9OrCFoC4/fLIn8cmHeeJ5D40kNr
 +Gl+JbJBNThoE6Hu+5qYHZD1rSNDMgxbg8EX6OQcQP/y1z1q3Bjkqx3eUmk6lGVtusRSVn/Gg
 Av4mOqXQHBIxKoKniqDVhT9VhM5HKsui/YqKkjOOESCp25GIWLtzOOR3OSItiTfNLl33W1pNt
 tj06HVZJuapd/X84WU1PsmhN9UtSQ4myZaM2OS1zAkvmanN1zU0KLvcfcPFdBf83uBEX6pIz7
 dk5vtDQBKdzxrwy/VkOgy/Wf3NgErJ53TxMQdC0V3zb7j8FJSb3umlwtcduXdW9Zk3Gjwe9gf
 qqsenBML2aXnUSqH7XGIVe2hJPCANro2A8ojeDlYUOo23i7RQQZ97uS2wodkSvtk0YRJQHstB
 q6zOY23u15JB7/BHFNREY3Hiilr+x+PjakXH3SXsSC9tTCo3D7w38nLqwF6x4YqybILCGgqal
 D0IFv7ni+boEoJcpY+8JmCh7FPzSzjBWxdXK2CsgFcX4oaQlpG5e5/+yXtNqIG/WBxXz5npbP
 W2f3p1ZvTQd9XfptpS26HwMeyHnLXc7AKPV8NBc1tWk2Ufta5jilUpjtkJZjeZKjtyGQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272705>

Hi Junio,

On 2015-06-25 15:14, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> - I *think* that the current `recreate_opt()` is fine, but if it
>> is used more, we will have to quote the arguments to guard against
>> spaces and quotes and whatnot
> 
> I admit that that was the reaction I had when I saw it for the first
> time, until I realized how it is used.  And this one I have to
> disagree.  recreate-opt is used to munge a single argument, suitable
> to be placed into argv[] for execv() like thing---there is no need
> for shell quoting there.  It is a job for the caller that gets its
> result to shell quote if it wants to pass the result to a shell.

Ah yes, no single command-line is constructed from those reconstructed options. So yes, you're right, all is good!

Ciao,
Dscho
