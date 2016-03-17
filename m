From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: bug: sparse config interpretation incorrectness in 2.8.0-rc2
Date: Thu, 17 Mar 2016 14:04:51 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603171402330.4690@virtualbox>
References: <56E9F5B3.6030903@fb.com> <20160317005632.GA17778@duynguyen-vnpc.dek-tpc.internal> <xmqq37rp35k1.fsf@gitster.mtv.corp.google.com> <CACsJy8A2D8CqeWZ6CFdTVXzXiWdonBE=3tWFPpe7-ZmDtNGYNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Durham Goode <durham@fb.com>,
	Git Mailing List <git@vger.kernel.org>,
	Mateusz Kwapich <mitrandir@fb.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 14:05:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agXby-0007m5-Vh
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 14:05:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935967AbcCQNFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 09:05:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:62621 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936076AbcCQNFF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 09:05:05 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LgNGi-1a3tSL32W4-00nftC; Thu, 17 Mar 2016 14:04:53
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CACsJy8A2D8CqeWZ6CFdTVXzXiWdonBE=3tWFPpe7-ZmDtNGYNw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:FZGXYQ/NY3udeg6qVt/Z+PtXe/jZ95BeUGMSh09EfFGNcpX3TCC
 ytWLdRbHgBKPDVELsaMg3S/u0DJOrEyn4V5HksiLIdS2FpTIhIq0icvzPFXK5cP1Uj6Fv1E
 IU3tDLwEXJrWL96B9sTWFGGY8XD6Sq4oeRvsMi3bzHTDYQQAWIOdCIFedmMYGrPDo2GJBP9
 x6HP8gdM21rGZzoi+wJsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5ay9DQgicDU=:rudSahaDQi0oKtblw69GbY
 CUh/LwHszCcimbEKYpXXyTdql3jfZsRWVphIGtk2eSvE7WtCgDSsTCuJAyL6cvlpWBTbssEbu
 Z/CRb4CjDoemPWeYRMQkQLvEVAVNEu3RyeTG31Oje1aabKmyTtqQeQroGJxFVNB8z/Odgangb
 jvv//zy3oJIgCA70Ah0ePU4WEtXJrrsmIrLJyq/QaoBcVS2onIw7HGfeBW2wL4bYRKemz/bkd
 6MaFoNC0ySVcAao9G6NkRSABLpbW4j6HRzYZGlMUtA5WdSaLmxTl/tUophHPc8NJ2Pf2boymY
 2T5N3GsqG8odhhynfv383ppkgCiEld5E1LB3AElFHXC2u63Pduxo6HFe/sQnoZ5QY+JEChoAO
 D0QZxtLhdfDgY6/AKRdftuLlYS+z1RR37mb1g7q/c3j4iXbwcfgspBNuEcZq8zJMdEU0/BSnE
 JtcbyN1lXrn8QhCWBdCsyfjE/nvv1bVjNn3DqUwmhGvr1AFaYfvOja6Myj4DiLMZfXkpvzFti
 i5Pv64V23oGafgUAGMJ47AuBah05EQBeQFK0Huf1NFHh4/dOb5FtwBDHXHYsNtWQyUkrQ4D1G
 NdhH14XipsQXBvBGiZbpBibm4zg/ACkaDTAJw5e+QoZ/oamclH1JWmnAfiaHSdOsIfJfzVzbp
 jQVE3YXqYDMgiar0icxmFV1TqGj5G6QxGHr9eKxP72DmJY/PhM2mMzmgd+Zyh0dZE46i/3SDU
 WYc0OjJDwmiZHV9MyNelsMT37rVU7H+YWEaPBNkUnVy3Wfdp2NhBqb5I71FtZJG3L4yVwqH6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289109>

Hi Duy,

On Thu, 17 Mar 2016, Duy Nguyen wrote:

> Good news for you is there's "sparse checkout v2" in the work, that
> would not rely on exclude engine and should be both faster and more
> elegant. That should reduce "sparse checkout v1" usage to really small
> cases.

I dabbled myself with speeding up the entire exclude engine (essentially,
I use a hash map of the non-wildcard prefixes to the corresponding line
number). So I am interested to see what your approach is. Could you point
me to it (I did not see any obvious branch in your GitHub space)?

Thanks,
Dscho
